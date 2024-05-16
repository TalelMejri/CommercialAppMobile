<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class AuthController extends Controller
{
    public function SignUpUser(Request $request)
    {

        User::create([
            'name' => $request->name,
            'email' => $request->email,
            'password' => bcrypt($request->password),
            'role' => "User",
            'phone' => $request->phone
        ]);

        return response()->json(["message" => "User Created"], 201);
    }

    public function AddEmployee(Request $request)
    {
        $user = User::create([
            'name' => $request->name,
            'email' => $request->email,
            'password' => bcrypt($request->password),
            'role' => "Employe",
            "phone" => $request->phone
        ]);

        return response()->json(["message" => "Employee Created"], 201);
    }

    public function DeleteUser(int $id)
    {
        $user = User::find($id);
        $user->delete();
        return response()->json(["message" => "User Deleted"], 200);
    }

    public function getEmploye(){
        $employe = User::where('role', 'Employe')->get();
        return response()->json(["data" => $employe], 200);
    }

    public function EditProfil(int $id, Request $request)
    {
        $user = User::find($id);
        $user->update([
            'name' => $request->name,
            'email' => $request->email,
            'phone' => $request->phone
        ]);

        return response()->json(["message" => "User Updated"], 200);
    }

    public function login(Request $request)
    {
        if (Auth::attempt(['email' => $request->email, 'password' => $request->password])) {
            $user = Auth::user();
            $role = $user->role;
            $response = [
                "id" => $user->id,
                "name" => $user->name,
                "email" => $user->email,
                "phone" => $user->phone,
                "role" => $role,
            ];
            return response()->json(["data" => $response], 200);
        } else {
            return response()->json(["data" => "Not Found"], 404);
        }
    }
}
