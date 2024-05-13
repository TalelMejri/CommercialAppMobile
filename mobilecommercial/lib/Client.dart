import 'package:flutter/material.dart';
import 'package:mobilecommercial/Models/user.dart';
import 'package:mobilecommercial/list_achat.dart';
import 'package:mobilecommercial/login.dart';
import 'package:mobilecommercial/service/AuthService.dart';


class ClientPage extends StatefulWidget {
  final User? user;
  ClientPage({Key? key, required this.user}) : super(key: key);

  @override
  State<ClientPage> createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage> {
  AuthService auth = AuthService();

  Future<void> _logout() async {
    await auth.logout();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  void _order() {
    Navigator.push(
        context, MaterialPageRoute(builder: (BuildContext) => ListAchat()));
  }

  void _viewHistory() {
    // Implement your view history logic here
    print("Viewing history!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user!.name),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'Logout':
                  _logout();
                  break;
                case 'Settings':
                  // Navigate to settings page
                  break;
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  value: 'Settings',
                  child: Text('Paramètres du compte'),
                ),
                PopupMenuItem(
                  value: 'Logout',
                  child: Text('Déconnexion'),
                ),
              ];
            },
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  child: Text(widget.user!.name[0]
                      .toUpperCase()), // Display the first letter
                ),
                SizedBox(width: 8),
                Text(widget.user!.name),
              ],
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext) => ListAchat()));
              },
              child: Text("Passer une commande"),
            ),
            ElevatedButton(
              onPressed: _viewHistory,
              child: Text("Consulter historique d'achat"),
            ),
          ],
        ),
      ),
    );
  }
}
