import 'package:flutter/material.dart';
import 'package:mobilecommercial/Models/Commande.dart';
import 'package:mobilecommercial/service/AuthService.dart';

class CommandePending extends StatefulWidget {
  const CommandePending({Key? key}) : super(key: key);

  @override
  State<CommandePending> createState() => _CommandePendingState();
}

class _CommandePendingState extends State<CommandePending> {
  List<Commande> commandes = [];
  AuthService auth = AuthService();

  Future<void> fetchCommandes() async {
    commandes = [];
    var commandes_get = await auth.GetCommandesPendig();
    setState(() {
      commandes = commandes_get;
    });
  }

  @override
  void initState() {
    super.initState();
    auth.getUserFromStorage().then((value) => fetchCommandes());
  }

  Future<void> AcceptedCommande(id, status) async {
    await auth.ChangerEtatCommande(id, status);
    fetchCommandes();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Commande Accepted"), backgroundColor: Colors.green));
  }

  Future<void> DeleteCommande(id) async {
    await auth.DeleteCommande(id);
    fetchCommandes();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Commande Rejected"), backgroundColor: Colors.green));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 25),
      child: Center(
        child: commandes.isEmpty
            ? Text("No Commandes Yet")
            : ListView.builder(
                itemCount: commandes.length,
                itemBuilder: (context, index) {
                  Commande item = commandes[index];
                  return ListTile(
                    leading: Text(item.id.toString()),
                    title: Text(item.type.toString()),
                    subtitle: Text(item.status.toString()),
                    trailing: SizedBox(
                      width: 160,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              AcceptedCommande(item.id, "Accepted");
                            },
                            icon: Icon(Icons.assignment_turned_in_rounded),
                            label: Text(""),
                          ),
                          SizedBox(width: 8),
                          ElevatedButton.icon(
                            onPressed: () {
                              DeleteCommande(item.id);
                            },
                            icon: Icon(Icons.delete_forever_rounded),
                            label: Text(""),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
