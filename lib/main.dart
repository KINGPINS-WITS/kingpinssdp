// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:kingpinssdp/current_user.dart';
import 'package:kingpinssdp/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/screens.dart';
import 'homepage.dart';

Future<void> main() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var savedEmail = prefs.getString('email');
  if(savedEmail!=null) {
    CurrentUser.email = savedEmail;
    CurrentUser.firstName = prefs.getString('firstname')!;
    CurrentUser.lastName = prefs.getString('lastname')!;
    CurrentUser.funds = prefs.getString('funds')!;
    CurrentUser.image = prefs.getString('image')!;
  }

  runApp(MaterialApp(home :(savedEmail==null) ? LoginPage() : HomePage(),
    debugShowCheckedModeBanner: false,
    routes: {
     // '/': (context) => LoginPage(),
      '/login': (context) => LoginPage(),
      '/home' : (context) => HomePage(),
      '/signup' : (context) => SignupPage(),
      '/profile' : (context) => ProfilePage(),
    },));
} //=> MyApp();

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
      // routes: {
      //   '/': (context) => LoginPage(),
      //   '/login': (context) => LoginPage(),
      //   '/home' : (context) => HomePage(),
      //   '/signup' : (context) => SignupPage(),
      //   '/profile' : (context) => ProfilePage(),
      // },
    );
  }
}