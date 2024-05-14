import 'package:flutter/material.dart';

import 'package:mobilecommercial/Loading.dart';
import 'package:mobilecommercial/PageHome.dart';
import 'package:mobilecommercial/service/AuthService.dart';

void main() {
  runApp(const HomePage());
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  Widget layout = LoadingWidget();

  AuthService authService = AuthService();

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
       authService.getUserFromStorage().then((value) =>
          setState((){
              layout=const LandingPage();// authService.isAuth ? ClientPage(user: authService.user) : LoginPage();
          })
       );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: layout);
  }

 
}
