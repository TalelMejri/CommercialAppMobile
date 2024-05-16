import 'package:flutter/material.dart';
import 'package:mobilecommercial/ListEmploye.dart';
import 'package:mobilecommercial/service/AuthService.dart';

import 'login.dart';

class AddEmploye extends StatefulWidget {
  const AddEmploye({Key? key}) : super(key: key);

  @override
  _AddEmployeState createState() => _AddEmployeState();
}

class _AddEmployeState extends State<AddEmploye> {
  String username = "";
  String email = "";
  String password = "";
  String phone = "";
  AuthService auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool Hidden = true;

  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      try {
        final registerOk =
            await auth.AddEmploye(username, email, password, phone);
        if (registerOk) {
           ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Employe Added"),
              backgroundColor: Colors.green));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Invalid Credentials"),
              backgroundColor: Colors.red));
        }
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          'Add Employe',
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),
                      child: TextFormField(
                        obscureText: Hidden,
                        enableSuggestions: false,
                        autocorrect: false,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'password is required';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            password = value;
                          });
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Enter your password',
                            suffixIcon: IconButton(
                              icon: Icon(!Hidden
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  Hidden = !Hidden;
                                });
                              },
                            )),
                      ),
                    ),
                    Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                        child: MaterialButton(
                          minWidth: double.infinity,
                          height: 60,
                          onPressed: () {
                            _signUp();
                          },
                          color: Colors.red,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40)),
                          child: Text(
                            "Add",
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
