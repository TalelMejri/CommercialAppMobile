import 'package:flutter/material.dart';
import 'package:mobilecommercial/EditProfil.dart';
import 'package:mobilecommercial/HistoriqueCommandeClient.dart';
import 'package:mobilecommercial/Models/Notif.dart';
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
  List<Notif> notifs = [];
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

  Future<void> fetchNotif() async {
    notifs = [];
    var notif_get = await auth.getNotifById(auth.user!.id);
    setState(() {
      notifs = notif_get;
    });
  }

  @override
  void initState() {
    super.initState();
    auth.getUserFromStorage().then((value) => fetchNotif());
  }

  void _viewHistory() {
    print("Viewing history!");
  }

  void _showNotificationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Notifications'),
          content: SingleChildScrollView(
            child: Column(
              children: notifs.map((notif) {
                return ListTile(
                  title: Text(notif.message),
                );
              }).toList(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Fermer'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(widget.user!.name),
            accountEmail: Text(widget.user!.email),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(widget.user!.name[0].toUpperCase()),
            ),
          ),
          ListTile(
            title: Text("Paramètres du compte"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext) => EditProfil()));
            },
          ),
          ListTile(
            title: Text("Déconnexion"),
            onTap: () {
              _logout();
            },
          ),
        ],
      )),
      appBar: AppBar(
        title: Text("Client"),
        actions: [
          ElevatedButton.icon(
              onPressed: () {
                _showNotificationDialog();
              },
              icon: Icon(Icons.notification_add_rounded),
              label: Text("")),
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
