import 'package:flutter/material.dart';
import 'package:mobilecommercial/Models/Commande.dart';
import 'package:mobilecommercial/service/AuthService.dart';

class getCommandesNotAccepted extends StatefulWidget {
  const getCommandesNotAccepted({Key? key}) : super(key: key);

  @override
  State<getCommandesNotAccepted> createState() => _getCommandesNotAcceptedState();
}

class _getCommandesNotAcceptedState extends State<getCommandesNotAccepted> {
  List<Commande> commandes = [];
  AuthService auth = AuthService();

  Future<void> fetchCommandes() async {
    commandes = [];
    var commandes_get = await auth.getCommandesNotAccepted();
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
                        
                          SizedBox(width: 8),
                          ElevatedButton.icon(
                            onPressed: () {
                             
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
