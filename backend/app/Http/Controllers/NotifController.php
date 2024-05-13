<?php

namespace App\Http\Controllers;

use App\Models\Notif;
use Illuminate\Http\Request;

class NotifController extends Controller
{
    public function getNotif($id)
    {
        $notifs = Notif::where("user_id", $id)->get();
        return response()->json($notifs, 200);
    }
}
