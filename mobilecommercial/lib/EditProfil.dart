import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mobilecommercial/Client.dart';
import 'package:mobilecommercial/service/AuthService.dart';

import 'login.dart';

class EditProfil extends StatefulWidget {
  const EditProfil({Key? key}) : super(key: key);

  @override
  _EditProfilState createState() => _EditProfilState();
}

class _EditProfilState extends State<EditProfil> {
  String username = "";
  String email = "";
  String phone = "";
  int id = -1;
  AuthService auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool Hidden = true;

  Future<void> editAccount() async {
    if (_formKey.currentState!.validate()) {
      try {
        final editprofil;
        editprofil = await auth.EditProfil(id, username, email, phone);
        if (editprofil) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) =>ClientPage(user: auth.user!)));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Somtheing went wrong"),
              backgroundColor: Colors.red));
        }
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    auth.getUserFromStorage().then((value) => setState(() {
          username = auth.user!.name;
          email = auth.user!.email;
          phone = auth.user!.phone;
          id = auth.user!.id;
        }));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Account'),
        backgroundColor: Colors.red,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                  padding: EdgeInsets.only(
                      top: 50.0, bottom: 2.0, left: 20.0, right: 20.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Edit Account !',
                          style: TextStyle(
                              fontSize: 25.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ])),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),
                      child: TextFormField(
                        initialValue: auth.user!.name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'username is required';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.name,
                        onChanged: (value) {
                          setState(() {
                            username = value;
                          });
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter your username',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),
                      child: TextFormField(
                        initialValue: email,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'email is required';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          setState(() {
                            email = value;
                          });
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter your email',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),
                      child: TextFormField(
                        initialValue: phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'phone is required';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.phone,
                        onChanged: (value) {
                          setState(() {
                            phone = value;
                          });
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter your phone',
                        ),
                      ),
                    ),
                    Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                        child: MaterialButton(
                          minWidth: double.infinity,
                          height: 60,
                          onPressed: () {
                            editAccount();
                          },
                          color: Colors.red,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40)),
                          child: Text(
                            "Edit",
                            style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Colors.white),
                          ),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
