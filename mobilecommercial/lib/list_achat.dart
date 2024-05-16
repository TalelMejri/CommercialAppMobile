import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobilecommercial/service/AuthService.dart';
import 'package:confetti/confetti.dart';
import 'dart:math';

class ListAchat extends StatefulWidget {
  const ListAchat({Key? key}) : super(key: key);

  @override
  State<ListAchat> createState() => _ListAchatState();
}

class _ListAchatState extends State<ListAchat> {
  var type = [
    {"id": 1, "type": "type1", "prix": 20},
    {"id": 2, "type": "test", "prix": 30},
  ];
  late ConfettiController _centerController;
  AuthService auth = AuthService();

  @override
  void initState() {
    super.initState();
    _centerController = ConfettiController(duration: const Duration(seconds: 5));
  }

  Future<void> PasseCommande(type, id, qte) async {
    auth.AddCommande(type, id, qte);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Added With Success'),backgroundColor: Colors.green,));
    _centerController.play();
    Future.delayed(const Duration(seconds: 2), () {
      _centerController.stop();
    });
    Navigator.of(context).pop();
  }

  Future<void> ShowMessage(item) async {
    int? quantity;
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Quantity For ' + item['type']),
          content: TextField(
            keyboardType: TextInputType.number,
            onChanged: (value) {
              quantity = int.tryParse(value);
            },
            decoration: InputDecoration(
              hintText: 'Enter quantity',
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Envoyer'),
              onPressed: () {
                if (quantity != null && quantity! > 0) {
                  PasseCommande(item['type'], auth.user!.id, quantity!);
                } else {
                  print('Invalid Quantity');
                }
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: 20,
          child: Align(
            alignment: Alignment.center,
            child: ConfettiWidget(
              confettiController: _centerController,
              blastDirection: pi / 2,
              maxBlastForce: 5,
              minBlastForce: 1,
              emissionFrequency: 0.03,
              numberOfParticles: 10,
              gravity: 0,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: type.length,
            itemBuilder: (context, index) {
              final item = type[index];
              return ListTile(
                leading: Text(item['id'].toString()),
                title: Text(item['type'].toString()),
                subtitle: Text(item['prix'].toString() + " dt"),
                trailing: ElevatedButton.icon(
                  onPressed: () => ShowMessage(item),
                  icon: Icon(Icons.money),
                  label: Text(""),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
