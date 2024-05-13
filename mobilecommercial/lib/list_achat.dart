import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobilecommercial/service/AuthService.dart';

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

  AuthService auth = AuthService();

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
                  print("dddd");
                  auth.AddCommande(item['type'], auth.user.id, quantity!);
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Added With Sucess')));
                  Navigator.of(context).pop();
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
    return Center(
      child: Expanded(
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
                label: Text("")),
          );
        },
      )),
    );
  }
}
