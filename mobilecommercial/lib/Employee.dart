import 'package:flutter/material.dart';
import 'package:mobilecommercial/ListCommandeAccepted.dart';
import 'package:mobilecommercial/Models/user.dart';
import 'package:mobilecommercial/login.dart';
import 'package:mobilecommercial/service/AuthService.dart';

class EmployeePage extends StatefulWidget {
  final User? user;
  EmployeePage({Key? key, required this.user}) : super(key: key);

  @override
  State<EmployeePage> createState() => _EmployeePageState();
}

class _EmployeePageState extends State<EmployeePage> {
  AuthService auth = AuthService();
  Future<void> _logout() async {
    auth.logout();
    auth.getUserFromStorage();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }


  @override
  void initState() {
    super.initState();
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
            title: Text("Déconnexion"),
            onTap: () {
              _logout();
            },
          ),
        ],
      )),
      appBar: AppBar(
        title: Text("Employee"),
      ),
      body: CommandeAccepted()
    );
  }
}
