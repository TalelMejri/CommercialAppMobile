import 'package:flutter/material.dart';
import 'package:mobilecommercial/Models/Commande.dart';
import 'package:mobilecommercial/service/AuthService.dart';

class CommandeAccepted extends StatefulWidget {
  const CommandeAccepted({Key? key}) : super(key: key);

  @override
  State<CommandeAccepted> createState() => _CommandeAcceptedState();
}

class _CommandeAcceptedState extends State<CommandeAccepted> {
  List<Commande> commandes = [];
  AuthService auth = AuthService();

  Future<void> fetchCommandes() async {
    commandes = [];
    var commandes_get = await auth.GetCommandeAccepted();
    setState(() {
      commandes = commandes_get;
    });
  }

  @override
  void initState() {
    super.initState();
    auth.getUserFromStorage().then((value) => fetchCommandes());
  }

  Future<void> ChangerEtatCommande(id, status) async {
    await auth.ChangerEtatCommande(id, status);
    fetchCommandes();
    ScaffoldMessenger.of(context).showSnackBar( SnackBar(
        content: Text("Commande $status"), backgroundColor: Colors.green));
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
                    subtitle: Text("Qte : "+item.qte.toString()),
                    trailing: SizedBox(
                      width: 160,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              ChangerEtatCommande(item.id, "Livrer");
                            },
                            icon: Icon(Icons.departure_board),
                            label: Text(""),
                          ),
                          SizedBox(width: 8),
                          ElevatedButton.icon(
                            onPressed: () {
                              ChangerEtatCommande(item.id,"Pret");
                            },
                            icon: Icon(Icons.system_security_update_good_rounded),
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
