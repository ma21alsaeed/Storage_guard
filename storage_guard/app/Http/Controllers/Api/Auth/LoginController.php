<?php

namespace App\Http\Controllers\Api\Auth;

use App\Models\User;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Http\Requests\User\LoginUserRequest;

class LoginController extends Controller
{
    public function __invoke(LoginUserRequest $request)
    {
        $data = $request->validated();
        if (auth()->attempt($data))
        {
            $user = User::where('email', $data['email'])->first();
            $token = $user->createToken('authToken')->plainTextToken;
            return response()->json(['token' => $token, 'user' => $user]);
        }
        return response()->json(['error' => 'The username or password is incorrect.'], 401);
    }
}
