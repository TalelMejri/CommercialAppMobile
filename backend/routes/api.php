<?php

use App\Http\Controllers\Auth\AuthController;
use App\Http\Controllers\CommandeController;
use App\Http\Controllers\NotifController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

Route::post("/RegisterUser", [AuthController::class, "SignUpUser"]);
Route::post("/AddEmployee", [AuthController::class, "AddEmployee"]);
Route::post("/login", [AuthController::class, "login"]);
Route::post("/Addcommande", [CommandeController::class, "AddCommande"]);
Route::put("/ChangerEtatCommande/{id}", [CommandeController::class, "ChangerEtatCommande"]);
Route::delete("/DeleteCommande/{id}", [CommandeController::class, "DeleteCommande"]);
Route::get("/GetCommandesPendig", [CommandeController::class, "GetCommandesPendig"]);
Route::get("/GetCommandesAccepted", [CommandeController::class, "GetCommandesAccepted"]);
Route::get("/GetCommandesByClient/{id}", [CommandeController::class, "GetCommandesByClient"]);
Route::get("/getCommandesNotAccepted", [CommandeController::class, "getCommandesNotAccepted"]);
Route::get("/getNotif/{id}", [NotifController::class, "getNotif"]);
Route::put("/EditProfil/{id}", [AuthController::class, "EditProfil"]);
Route::delete("/DeleteUser/{id}", [AuthController::class, "DeleteUser"]);
Route::get("/getAllEmploye", [AuthController::class, "getEmploye"]);




