import 'package:flutter/material.dart';
import 'package:mobilecommercial/HistoriqueCommandeClient.dart';
import 'package:mobilecommercial/Models/user.dart';
import 'package:mobilecommercial/list_achat.dart';
import 'package:mobilecommercial/login.dart';
import 'package:mobilecommercial/service/AuthService.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class ClientPage extends StatefulWidget {
  final User? user;
  ClientPage({Key? key, required this.user}) : super(key: key);

  @override
  State<ClientPage> createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage> {
  AuthService auth = AuthService();

  Future<void> _logout() async {
    auth.logout();
    auth.getUserFromStorage();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  void _order() {
    Navigator.push(
        context, MaterialPageRoute(builder: (BuildContext) => ListAchat()));
  }

  int _selectIndex = 1;
  void changeSelectedINdex(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  void _viewHistory() {
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
                ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.notification_add_rounded),
                    label: Text("")),
                CircleAvatar(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  child: Text(widget.user!.name[0].toUpperCase()),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CurvedNavigationBar(
          color: const Color(0xFF9E653B),
          buttonBackgroundColor: const Color(0xFF9E653B),
          backgroundColor: Colors.white,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 600),
          onTap: (index) {
            changeSelectedINdex(index);
          },
          index: _selectIndex,
          items: <Widget>[
            Icon(
              Icons.list,
              color: Colors.white,
            ),
            Icon(
              Icons.history,
              color: Colors.white,
            ),
          ]),
      body: _selectIndex == 0 ? ListAchat() : ListHistoriqueCmmande(),
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //       ElevatedButton(
      //         onPressed: () {
      //           Navigator.push(context,
      //               MaterialPageRoute(builder: (BuildContext) => ListAchat()));
      //         },
      //         child: Text("Passer une commande"),
      //       ),
      //       ElevatedButton(
      //         onPressed: _viewHistory,
      //         child: Text("Consulter historique d'achat"),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
