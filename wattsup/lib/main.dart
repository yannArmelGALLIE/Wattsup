import 'package:flutter/material.dart';
import 'package:wattsup/pages/authentication/login/login_page.dart';
import 'package:wattsup/pages/authentication/register/register_page.dart';
import 'package:wattsup/pages/navigation/navigation.dart';
import 'package:wattsup/pages/welcome_page/welcome.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: WelcomePage(),
      initialRoute: '/',
      routes: {
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/home': (context) => NavBar(),
      },
    );
  }
}