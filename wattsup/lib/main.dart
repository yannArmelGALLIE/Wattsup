import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:wattsup/pages/authentication/login/login_page.dart';
import 'package:wattsup/pages/authentication/register/register_page.dart';
import 'package:wattsup/pages/navigation/navigation.dart';
import 'package:wattsup/pages/welcome_page/welcome.dart';
import 'package:wattsup/providers/mesure_provider.dart';
import 'package:wattsup/providers/user_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => MesureProvider()), 
      ],
      child: const MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'WattsUp',
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