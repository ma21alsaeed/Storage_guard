<?php

namespace App\Http\Controllers\Api\Auth;


use App\Models\User;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Http\Resources\UserResources;
use App\Http\Requests\User\LoginUserRequest;
use App\Http\Requests\User\StoreUserRequest;
use App\Http\Requests\User\UpdateUserRequest;


class UserController extends Controller
{
    public function index(Request $request)
    {

        $id = $request->input('id');
        if ($id)
        {
            $user = User::find($id);
            if (!$user)
            {
                return response()->json(['error' => 'User not found'], 404);
            }
            return response()->json($user);
        }
        return response()->json(User::all());


    }
    public function store(StoreUserRequest $request)
    {
        $data = $request->validated();
        $data['password'] = bcrypt($data['password']);
        $user = User::create($data);
        $token = $user->createToken('authToken')->plainTextToken;
        return response()->json(['token' => $token, 'user' => $user]);
    }

    public function update(UpdateUserRequest $request, User $user)
    {
        if (auth()->user()->rule == 1 | auth()->user()->id == $user->id)
        {
            $data = $request->validated();
            if (array_key_exists('password', $data))
                $data['password'] = bcrypt($data['password']);
            $user->fill($data);
            $user->save();
            return response()->json(['masseage' => "The user's information has been updated successfully.", 'user' => $user], 201);
        }
        return response()->json(['message' => 'Unauthorized'], 401);
    }
    public function destroy(User $user)
    {
        if (auth()->user()->rule == 1 | auth()->user()->id == $user->id)
        {
            $user->delete();
            return response()->json(['masseage' => 'The user account has been deleted successfully.'], 200);
        }
        return response()->json(['message' => 'Unauthorized'], 401);
    }
}
