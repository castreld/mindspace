<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rule;
use Illuminate\Auth\Events\Login; // Import the Login event
use Illuminate\Auth\Events\Logout; // Import the Logout event

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
        ]);

        event(new Login(auth()->guard('web'), $user, false));

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

        event(new Login(auth()->guard('web'), $user, $request->boolean('remember')));

        $token = $user->createToken('auth_token')->plainTextToken;

        return response()->json([
           'message' => 'Login successful',
           'access_token' => $token,
           'token_type' => 'Bearer',
           'user' => $user,
        ]);
    }

    public function logout(Request $request)
    {
        $user = $request->user();

        event(new Logout(auth()->guard('web'), $user));

        $request->user()->currentAccessToken()->delete();

        return response()->json([
            'message' => 'Successfully logged out'
        ]);
    }
}