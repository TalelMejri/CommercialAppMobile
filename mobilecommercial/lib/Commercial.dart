import 'package:flutter/material.dart';
import 'package:mobilecommercial/AddEmploy.dart';
import 'package:mobilecommercial/AllCommandes.dart';
import 'package:mobilecommercial/CommandesPending.dart';
import 'package:mobilecommercial/HistoriqueCommandeClient.dart';
import 'package:mobilecommercial/ListEmploye.dart';
import 'package:mobilecommercial/Models/Notif.dart';
import 'package:mobilecommercial/Models/user.dart';
import 'package:mobilecommercial/list_achat.dart';
import 'package:mobilecommercial/login.dart';
import 'package:mobilecommercial/service/AuthService.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class CommercialPage extends StatefulWidget {
  final User? user;
  CommercialPage({Key? key, required this.user}) : super(key: key);

  @override
  State<CommercialPage> createState() => _CommercialPageState();
}

class _CommercialPageState extends State<CommercialPage> {
  AuthService auth = AuthService();
  List<Notif> notifs = [];

  Future<void> _logout() async {
    await auth.logout();
    await auth.getUserFromStorage();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  void _order() {
    Navigator.push(
        context, MaterialPageRoute(builder: (BuildContext) => ListAchat()));
  }

  int _selectIndex = 1;

  void changeSelectedIndex(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  Future<void> fetchNotif() async {
    try {
      var notifGet = await auth.getNotifById(auth.user!.id);
      setState(() {
        notifs = notifGet;
      });
    } catch (e) {
      print('Error fetching notifications: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    auth.getUserFromStorage().then((value) {
      if (auth.user != null) {
        fetchNotif();
      }
    });
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
            if (widget.user != null)
              UserAccountsDrawerHeader(
                accountName: Text(widget.user!.name),
                accountEmail: Text(widget.user!.email),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text(widget.user!.name[0].toUpperCase()),
                ),
              ),
            ListTile(
              title: Text("Déconnexion"),
              onTap: () {
                _logout();
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("Commercial"),
        actions: [
          ElevatedButton.icon(
            onPressed: () {
              _showNotificationDialog();
            },
            icon: Icon(Icons.notification_add_rounded),
            label: Text(""),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.black,
        buttonBackgroundColor: Colors.black,
        backgroundColor: Colors.white,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 600),
        onTap: (index) {
          changeSelectedIndex(index);
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
          Icon(
            Icons.manage_accounts,
            color: Colors.white,
          ),
          Icon(
            Icons.supervised_user_circle,
            color: Colors.white,
          ),
        ],
      ),
      body: _selectIndex == 0
          ? const CommandePending()
          : _selectIndex == 1
              ? const getCommandesNotAccepted()
              : _selectIndex == 2
                  ? const AddEmploye()
                  : const ListEmploye(),
    );
  }
}
