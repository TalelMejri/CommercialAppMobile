<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class AuthController extends Controller
{
    public function SignUpUser(Request $request){

         User::create([
            'name'=>$request->name,
            'email'=>$request->email,
            'password'=>bcrypt($request->password),
            'Role'=>"User",
            'phone'=>$request->phone
        ]);

        return response()->json(["message"=>"User Created"],201);
    }

    // public function AddEmployee(Request $request){
    //    $user=User::create([
    //         'name'=>$request->name,
    //         'email'=>$request->email,
    //         'password'=>bcrypt($request->password),
    //         'Role'=>"User",
    //         "department_id"=>$request->department_id,
    //         "phone"=>$request->phone
    //     ]);

    //     return response()->json(["message"=>"Employee Created"],201);
    // }

    public function login(Request $request){
        if(Auth::attempt(['email'=>$request->email,'password'=>$request->password])){
            $user = Auth::user();
            $role= $user->role;
            $response=[
                "id"=> $user->id,
                "name"=>$user->name,
                "email"=>$user->email,
                "phone"=>$user->phone,
                "role"=>$role,
            ];
            return response()->json(["data"=> $response],200);
        }else{
            return response()->json(["data"=> "Not Found"],404);
        }
    }
}
