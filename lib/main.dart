// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:kingpinssdp/signup.dart';
import 'screens/screens.dart';
import 'homepage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'StuMarket',
      theme: ThemeData(

        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/login': (context) => LoginPage(),
        '/home' : (context) => HomePage(),
        '/signup' : (context) => SignupPage(),
        '/profile' : (context) => ProfilePage(),
      },
    );
  }
}