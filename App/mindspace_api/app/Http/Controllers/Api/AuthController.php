<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rule;
use Illuminate\Auth\Events\Login;
use Illuminate\Auth\Events\Logout;
use Illuminate\Support\Str;
use Laravel\Socialite\Facades\Socialite;
use Exception;
use Illuminate\Support\Facades\Log;

class AuthController extends Controller
{
    public function register(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'username' => 'required|string|max:255|unique:users',
            'full_name' => 'required|string|max:255',
            'email' => 'required|string|email|max:255|unique:users',
            'password' => 'required|string|min:8',
            'birth_date' => 'required|string',
            'gender' => ['required', Rule::in(['pria', 'wanita'])],
            'phone_number' => 'required|string|max:15',
            'flyer' => ['required', Rule::in(['yes', 'no'])],
            'category' => ['required', Rule::in(['Umum', 'Mahasiswa Aktif Unpad', 'Dosen / Tenaga Kependidikan Unpad'])],
        ]);

        if ($validator->fails()) {
            return response()->json($validator->errors(), 422);
        }

        $defaultProfilePicture = $request->gender === 'pria'
            ? 'storage/profilepictures/man_placeholder.png'
            : 'storage/profilepictures/woman_placeholder.png';

        $user = User::create([
            'username' => $request->username,
            'full_name' => $request->full_name,
            'email' => $request->email,
            'password' => Hash::make($request->password),
            'birth_date' => $request->birth_date,
            'gender' => $request->gender,
            'phone_number' => $request->phone_number,
            'flyer' => $request->flyer,
            'category' => $request->category,
            'role' => 'klien',
            'profile_picture' => $defaultProfilePicture,
        ]);

        event(new Login('web', $user, false));

        $token = $user->createToken('auth_token')->plainTextToken;

        return response()->json([
            'message' => 'User successfully registered',
            'access_token' => $token,
            'token_type' => 'Bearer',
            'user' => $user,
        ], 201);
    }

    public function login(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'username' => 'required|string',
            'password' => 'required|string',
        ]);

        if ($validator->fails()) {
            return response()->json($validator->errors(), 422);
        }

        if (!Auth::attempt($request->only('username', 'password'))) {
            return response()->json([
                'message' => 'Invalid login details'
            ], 401);
        }

        $user = User::where('username', $request['username'])->firstOrFail();

        event(new Login('web', $user, $request->boolean('remember')));

        $token = $user->createToken('auth_token')->plainTextToken;

        return response()->json([
            'message' => 'Login successful',
            'access_token' => $token,
            'token_type' => 'Bearer',
            'user' => $user,
        ]);
    }

    public function redirectToGoogle()
    {
        return Socialite::driver('google')->stateless()->redirect();
    }

    public function handleGoogleCallback(Request $request)
    {
        try {
            $googleUser = Socialite::driver('google')->stateless()->user();
            
            $user = User::where('google_id', $googleUser->getId())->first();

            if (!$user) {
                $user = User::where('email', $googleUser->getEmail())->first();

                if (!$user) {
                    $baseUsername = Str::before($googleUser->getEmail(), '@');
                    $username = $baseUsername;
                    $counter = 1;

                    while (User::where('username', $username)->exists()) {
                        $username = $baseUsername . $counter;
                        $counter++;
                    }

                    $user = User::create([
                        'google_id' => $googleUser->getId(),
                        'full_name' => $googleUser->getName(),
                        'username' => $username,
                        'email' => $googleUser->getEmail(),
                        'profile_picture' => $googleUser->getAvatar() ?? 'storage/profilepictures/man_placeholder.png',
                        'password' => null,
                        'birth_date' => '-',
                        'gender' => 'pria',
                        'phone_number' => '-',
                        'flyer' => 'no',
                        'category' => 'Umum',
                        'role' => 'klien',
                    ]);
                } else {
                    $user->google_id = $googleUser->getId();
                    if (empty($user->profile_picture) || str_contains($user->profile_picture, 'placeholder.png')) {
                        $user->profile_picture = $googleUser->getAvatar();
                    }
                    $user->save();
                }
            }

            $updateData = ['google_token' => $googleUser->token];
            if ($googleUser->refreshToken) {
                $updateData['google_refresh_token'] = $googleUser->refreshToken;
            }
            $user->update($updateData);

            Log::info('About to create token for user: ' . $user->id);
            $token = $user->createToken('auth_token')->plainTextToken;
            Log::info('Token created successfully');

            $userData = base64_encode(json_encode($user));
            
            $platform = $request->query('platform', 'web');
            
            if ($platform === 'mobile' || $platform === 'desktop') {
                return redirect("mindspace://auth/callback?token={$token}&user={$userData}");
            } else {
                $frontendUrl = config('app.frontend_url', 'https://mindspace.asia');
                return redirect("{$frontendUrl}/auth/callback?token={$token}&user={$userData}");
            }
            
        } catch (Exception $e) {
            Log::error('Google Callback Error: ' . $e->getMessage());
            Log::error('Stack trace: ' . $e->getTraceAsString());
            Log::error('Line: ' . $e->getLine());
            
            $frontendUrl = config('app.frontend_url', 'https://mindspace.asia');
            return redirect("{$frontendUrl}/login?error=google_failed");
        }
    }

    public function logout(Request $request)
    {
        $user = $request->user();

        event(new Logout('web', $user));

        $request->user()->currentAccessToken()->delete();

        return response()->json([
            'message' => 'Successfully logged out'
        ]);
    }
}