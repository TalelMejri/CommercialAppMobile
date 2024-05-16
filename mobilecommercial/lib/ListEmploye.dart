import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobilecommercial/Models/user.dart';
import 'package:mobilecommercial/service/AuthService.dart';

class ListEmploye extends StatefulWidget {
  const ListEmploye({Key? key}) : super(key: key);

  @override
  State<ListEmploye> createState() => _ListEmployeState();
}

class _ListEmployeState extends State<ListEmploye> {
  List<User> users = [];
  AuthService auth = AuthService();

  Future<void> fetchEmploye() async {
    users = [];
    var users_get = await auth.getAllEmploye();
    setState(() {
      users = users_get;
    });
  }

  Future<void> deleteEmploye(int id) async {
    await auth.DeleteEmploye(id);
    fetchEmploye();
  }

  @override
  void initState() {
    super.initState();
    auth.getUserFromStorage().then((value) => fetchEmploye());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.only(top: 25), child: Center(
      child: users.length == 0
          ? Text("No users Yet")
          : ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                User item = users[index];
                return ListTile(
                  leading: Text(item.id.toString()),
                  title: Text(item.name.toString()),
                  subtitle: Text(item.email.toString()),
                  trailing: ElevatedButton.icon(
                    onPressed: () {
                      deleteEmploye(item.id);
                    },
                    icon:  Icon(Icons.delete),
                    label: Text(""),
                  ),
                );
              },
            ),
    ));
  }
}
