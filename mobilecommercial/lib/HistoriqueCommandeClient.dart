import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobilecommercial/Models/Commande.dart';
import 'package:mobilecommercial/service/AuthService.dart';

class ListHistoriqueCmmande extends StatefulWidget {
  const ListHistoriqueCmmande({Key? key}) : super(key: key);

  @override
  State<ListHistoriqueCmmande> createState() => _ListHistoriqueCmmandeState();
}

class _ListHistoriqueCmmandeState extends State<ListHistoriqueCmmande> {
  List<Commande> commandes = [];
  AuthService auth = AuthService();

  Future<void> fetchCommandes() async {
    commandes = [];
    var commandes_get = await auth.GetCommandeById(auth.user.id);
    setState(() {
      commandes = commandes_get;
    });
  }

  @override
  void initState() {
    super.initState();
    auth.getUserFromStorage().then((value) => fetchCommandes());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.only(top: 25), child: Center(
      child: commandes.length == 0
          ? Text("No Commandes Yet")
          : ListView.builder(
              itemCount: commandes.length,
              itemBuilder: (context, index) {
                Commande item = commandes[index];
                return ListTile(
                  leading: Text(item.id.toString()),
                  title: Text(item.type.toString()),
                  subtitle: Text(item.status.toString()),
                  trailing: ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.delete),
                    label: Text(""),
                  ),
                );
              },
            ),
    ));
  }
}
