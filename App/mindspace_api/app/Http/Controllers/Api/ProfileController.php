<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\Rule;
use Illuminate\Validation\Rules\Password; 

class ProfileController extends Controller
{
    public function update(Request $request)
    {
        $user = $request->user();

        $validatedData = $request->validate([
            'profile_picture' => 'nullable|image|mimes:jpeg,png,jpg|max:2048',
            'username' => [
                'required',
                'string',
                'max:255',
                Rule::unique('users')->ignore($user->id),
            ],
            'full_name' => 'required|string|max:255',
            'email' => [
                'required',
                'string',
                'email',
                'max:255',
                Rule::unique('users')->ignore($user->id),
            ],
            'phone_number' => 'required|string|max:15',
            'birth_date' => 'required|date',
            'gender' => ['required', Rule::in(['pria', 'wanita'])],
            'flyer' => ['required', Rule::in(['yes', 'no'])],
        ]);

        // Handle profile picture upload
        if ($request->hasFile('profile_picture')) {
            $file = $request->file('profile_picture');
            $filename = time() . '_' . $user->id . '.' . $file->getClientOriginalExtension();
            $file->storeAs('public/profilepictures', $filename);
            $validatedData['profile_picture'] = 'storage/profilepictures/' . $filename;
        }

        $user->update($validatedData);

        return response()->json([
            'message' => 'Profile updated successfully!',
            'user' => $user->fresh(),
        ]);
    }

    public function updatePassword(Request $request)
    {
        $user = $request->user();

        $request->validate([
            'current_password' => 'required|string',
            'new_password' => ['required', 'confirmed', Password::min(8)],
        ]);

        
        if (!Hash::check($request->current_password, $user->password)) {
            return response()->json(['message' => 'Password saat ini salah.'], 422);
        }

        
        $user->password = Hash::make($request->new_password);
        $user->save();

        return response()->json(['message' => 'Password berhasil diubah.']);
    }

    public function destroy(Request $request)
    {
        $user = $request->user();

        $request->validate([
            'current_password' => 'required|string',
        ]);

        
        if (!Hash::check($request->current_password, $user->password)) {
            return response()->json(['message' => 'Password salah, akun tidak dapat dihapus.'], 422);
        }

        
        $user->tokens()->delete();
        $user->delete();

        return response()->json(['message' => 'Akun Anda telah berhasil dihapus.']);
    }
}