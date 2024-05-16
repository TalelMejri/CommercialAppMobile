import 'package:flutter/material.dart';
import 'package:mobilecommercial/Client.dart';
import 'package:mobilecommercial/Commercial.dart';
import 'package:mobilecommercial/Models/user.dart';
import 'package:mobilecommercial/login.dart';
import 'package:mobilecommercial/service/AuthService.dart';
import 'package:mobilecommercial/signup.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  bool auth = false;
  AuthService authService = AuthService();
  late User user;
  void getAuth() async {
    authService.getUserFromStorage().then((value) => setState(() {
          auth = authService.isAuth;
          user = authService.user!;
        }));
  }

  Future<void> Logout() async {
    authService.logout();
    getAuth();
  }

  @override
  dispose() {
    super.dispose();
    getAuth();
  }

  @override
  void initState() {
    super.initState();
    getAuth();
  }

  Future<void> CheckRole() async {
    if (authService.user!.role == "Commercial") {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => CommercialPage(user: user)));
    } else if(authService.user!.role == "User") {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ClientPage(
                    user: user,
                  )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset("images/back.jpg", fit: BoxFit.cover),
          Container(
            color: Colors.black.withOpacity(0.4),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 120.0),
                  const Text(
                    "Welcome For Our App",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20.0),
                  const Text(
                    "Commercial",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 100.0),
                  Visibility(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        CheckRole();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 5,
                      ),
                      icon:
                          const Icon(Icons.highlight_sharp, color: Colors.red),
                      label: const Text(
                        "Welcome",
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                    visible: auth,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Visibility(
                        visible: !auth,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()));
                          },
                          icon: const Icon(
                            Icons.account_circle,
                            color: Colors.black,
                          ),
                          label: const Text(
                            "Login",
                            style: TextStyle(color: Colors.black),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 5,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Visibility(
                        visible: !auth,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignupPage()));
                          },
                          icon: const Icon(
                            Icons.manage_accounts,
                            color: Colors.black,
                          ),
                          label: const Text(
                            "Signup",
                            style: TextStyle(color: Colors.black),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 5,
                          ),
                        ),
                      ),
                      Visibility(
                        visible: auth,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Logout();
                          },
                          icon: const Icon(
                            Icons.logout,
                            color: Colors.black,
                          ),
                          label: const Text(
                            "Logout",
                            style: TextStyle(color: Colors.black),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 5,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 450,
                  ),
                  const Text(
                    '© 2024. All rights reserved.',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
