import 'package:flutter/material.dart';
import 'package:mobilecommercial/service/AuthService.dart';


import 'login.dart'; // Make sure this points to your LoginPage class correctly.

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String username = "";
  String email = "";
  String password = "";
  String phone = "";
  AuthService auth = AuthService();
  Future<void> _signUp() async {
    try {
      final registerOk =
          await auth.RegisterUser(username, email, password, phone);
      if (registerOk) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Invalid Credentials"), backgroundColor: Colors.red));
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 60.0),
              const SizedBox(height: 20.0),

              TextField(
                onChanged: (val) {
                  setState(() {
                    username = val;
                  });
                },
                decoration: InputDecoration(
                  hintText: "name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Colors.blue.withOpacity(0.1),
                  filled: true,
                  prefixIcon: const Icon(Icons.account_balance),
                ),
                obscureText: false,
              ),
              // Email text field
              const SizedBox(height: 20.0),
              const SizedBox(height: 20.0),
              TextField(
                keyboardType: TextInputType.emailAddress,
                onChanged: (val) {
                  setState(() {
                    email = val;
                  });
                },
                decoration: InputDecoration(
                  hintText: "email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Colors.blue.withOpacity(0.1),
                  filled: true,
                  prefixIcon: const Icon(Icons.email),
                ),
                obscureText: false,
              ),
              const SizedBox(height: 20.0),
              // Password text field
              TextField(
                onChanged: (val) {
                  setState(() {
                    password = val;
                  });
                },
                decoration: InputDecoration(
                  hintText: "****",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Colors.blue.withOpacity(0.1),
                  filled: true,
                  prefixIcon: const Icon(Icons.password),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20.0),
              const SizedBox(height: 20.0),
              TextField(
                onChanged: (val) {
                  setState(() {
                    phone = val;
                  });
                },
                decoration: InputDecoration(
                  hintText: "+216",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Colors.blue.withOpacity(0.1),
                  filled: true,
                  prefixIcon: const Icon(Icons.phone),
                ),
                obscureText: false,
              ),
              const SizedBox(height: 20.0),
              // Sign up button
              ElevatedButton(
                onPressed: _signUp,
                child: const Text(
                  "Sign up",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(height: 20.0),
              // Already have an account? Login text
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
                child: Text(
                  "Already have an account? Login",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.blue,
                      decoration: TextDecoration.underline),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
