<?php

namespace App\Http\Controllers;

use App\Models\Commande;
use App\Models\Notif;
use App\Models\User;
use Illuminate\Http\Request;

class CommandeController extends Controller
{
    public function AddCommande(Request $request)
    {
        Commande::create([
            "type" => $request->type,
            "qte" => $request->qte,
            "IdClient" => $request->IdClient,
            "status" => "Pending",
        ]);
        $userSend = User::find($request->IdClient);
        $userCommercial = User::where("role", "Commercial")->first();
        Notif::create([
            "message" => $userSend->name . "Added New Commande",
            "user_id" => $userCommercial->id,
        ]);
        return response()->json(["message" => "Commande Added"], 201);
    }

    public function ChangerEtatCommande(int $id, Request $request)
    {
        $commande = Commande::find($id);
        $commande->update([
            "status" => $request->status,
        ]);
        $Client = User::find($commande->IdClient);
        Notif::create([
            "message" => "Your Commande " . $Client->name . " is " . $request->status,
            "user_id" =>  $commande->IdClient,
        ]);

        return response()->json(["message" => "Commande Updated"], 200);
    }


    public function getCommandesNotAccepted(){
        $commandes = Commande::where("status", "!=", "Pending")->get();
        return response()->json($commandes, 200);
    }
    public function DeleteCommande(int $id)
    {
        $commande = Commande::find($id);
        $Client = User::find($commande->IdClient);
        Notif::create([
            "message" => "Your Commande " . $Client->name . " is " ."Rejected",
            "user_id" =>  $commande->IdClient,
        ]);
        $commande->delete();
        return response()->json(["message" => "Commande Deleted"], 200);
    }

    public function GetCommandesPendig()
    {
        $commandes = Commande::where("status", "Pending")->get();
        return response()->json($commandes, 200);
    }

    public function GetCommandesAccepted()
    {
        $commandes = Commande::where("status", "Accepted")->get();
        return response()->json($commandes, 200);
    }

    public function GetCommandesByClient(int $id)
    {
        $commandes = Commande::where("IdClient", $id)->get();
        return response()->json($commandes, 200);
    }
}
