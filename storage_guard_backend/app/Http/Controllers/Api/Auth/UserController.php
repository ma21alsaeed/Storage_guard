<?php

namespace App\Http\Controllers\Api\Auth;


use App\Models\User;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Http\Requests\User\StoreUserRequest;
use App\Http\Requests\User\UpdateUserRequest;
use Illuminate\Database\Eloquent\ModelNotFoundException;

//dddadwqfpoq
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
                return response()->json(['message' => 'User not found'], 404);
            }

            return response()->json($user);
        }

        $users = User::all();
        return response()->json($users);
    }
    public function store(StoreUserRequest $request)
    {
        $data = $request->validated();
        $data['password'] = bcrypt($data['password']);
        $user = User::create($data);
        $token = $user->createToken('authToken')->plainTextToken;
        return response()->json(['token' => $token, 'user' => $user]);
    }
    public function update(UpdateUserRequest $request, $userId)
    {
        try
        {
            $user = User::findOrFail($userId);
        }
        catch (ModelNotFoundException $e)
        {
            return response()->json(['message' => 'User not found'], 404);
        }
        if (auth()->user()->rule !== 1 && auth()->user()->id !== $user->id)
        {
            return response()->json(['message' => 'Unauthorized'], 403);
        }

        $data = $request->validated();
        if (array_key_exists('password', $data))
        {
            $data['password'] = bcrypt($data['password']);
        }
        $user->fill($data);
        $user->save();
        return response()->json(['message' => "The user's information has been updated successfully.", 'user' => $user], 200);
    }
    public function destroy($userId)
    {
        try
        {
            $user = User::findOrFail($userId);
        }
        catch (ModelNotFoundException $e)
        {
            return response()->json(['message' => 'User not found'], 404);
        }

        if (auth()->user()->rule !== 1 && auth()->user()->id !== $user->id)
        {
            return response()->json(['message' => 'Unauthorized'], 401);
        }

        $user->delete();

        return response()->json(['message' => 'The user account has been deleted successfully.'], 204);
    }
}
