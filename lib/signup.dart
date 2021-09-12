// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:kingpinssdp/current_user.dart';
import 'package:kingpinssdp/screens/login_page.dart';
import 'package:fluttertoast/fluttertoast.dart';


import '../homepage.dart';

class SignupPage extends StatefulWidget{
  const SignupPage({Key? key}) : super(key: key);
  @override
  SignupPageState createState() => SignupPageState();
}


class SignupPageState extends State<SignupPage>{

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Login Failed'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Invalid login details provided, Try again!'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Okay'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future registration(BuildContext context) async {
    var url =
        "https://lamp.ms.wits.ac.za/home/s2280727/kingpins/Registration.php";
    var response = await http.post(Uri.parse(url), body: {
      "firstname": firstnameController.text,
      "lastname": lastnameController.text,
      "email": emailController.text,
      "password": passwordController.text,
    });
    var data = response.body;
    if (data == "You are registered") {
      Fluttertoast.showToast(
        msg: "Successfully registered",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        fontSize: 16.0,
      );
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LoginPage()),
      );

      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => LoginPage()));
    } else {
      Fluttertoast.showToast(
        msg: data,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        fontSize: 16.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Column(
        children: [
          Container(
            color: Colors.blue[900],
            child: Center(
              child: Text(
                'REGISTER YOUR ACCOUNT',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 60,
                    fontWeight: FontWeight.bold),
              ),
            ),

          ),
          Form(
            key: formkey,
            autovalidateMode: AutovalidateMode.always,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Container(
                    height: 60,
                    width: 400,
                    decoration: BoxDecoration(
                      color: Colors.grey[200]!.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: TextFormField(
                        key: Key("FirstNameField"),
                        controller: firstnameController,
                        validator: RequiredValidator(errorText: "Required field!"),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Icon(
                              Icons.person,
                              size: 28,
                              color: Colors.black,
                            ),
                          ),
                          hintText: "First Name",
                          hintStyle: TextStyle(fontSize: 22, color: Colors.grey[400], height: 1.5),
                        ),
                        obscureText: false,
                        style: TextStyle(fontSize: 22, color: Colors.black, height: 1.5),
                        keyboardType: TextInputType.text,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Container(
                    height: 60,
                    width: 400,
                    decoration: BoxDecoration(
                      color: Colors.grey[200]!.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: TextFormField(
                        key: Key("LastNameField"),
                        controller: lastnameController,
                        validator: RequiredValidator(errorText: "Required field!"),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Icon(
                              Icons.person,
                              size: 28,
                              color: Colors.black,
                            ),
                          ),
                          hintText: "Last Name",
                          hintStyle: TextStyle(fontSize: 22, color: Colors.grey[400], height: 1.5),
                        ),
                        obscureText: false,
                        style: TextStyle(fontSize: 22, color: Colors.black, height: 1.5),
                        keyboardType: TextInputType.text,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Container(
                    height: 60,
                    width: 400,
                    decoration: BoxDecoration(
                      color: Colors.grey[200]!.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(16),

                    ),
                    child: Center(
                      child: TextFormField(
                          key: Key("EmailField"),
                          controller: emailController,
                          validator: MultiValidator(
                              [
                                RequiredValidator(errorText: "Required field!"),
                                EmailValidator(errorText: "Invalid email address!"),
                              ]
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Icon(
                                Icons.mail,
                                size: 28,
                                color: Colors.black,
                              ),
                            ),
                            hintText: "Email",
                            hintStyle: TextStyle(fontSize: 22, color: Colors.grey[400], height: 1.5),
                          ),
                          style: TextStyle(fontSize: 22, color: Colors.black, height: 1.5),
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Container(
                    height: 60,
                    width: 400,
                    decoration: BoxDecoration(
                      color: Colors.grey[200]!.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: TextFormField(
                        key: Key("PasswordField"),
                        controller: passwordController,
                        validator: RequiredValidator(errorText: "Required field!"),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Icon(
                              Icons.lock,
                              size: 28,
                              color: Colors.black,
                            ),
                          ),
                          hintText: "Password",
                          hintStyle: TextStyle(fontSize: 22, color: Colors.grey[400], height: 1.5),
                        ),
                        obscureText: true,
                        style: TextStyle(fontSize: 22, color: Colors.black, height: 1.5),
                        keyboardType: TextInputType.text,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical:15, horizontal:0 ),
                  child: Container(
                    height: 60,
                    width: 400,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Colors.blue[900],
                    ),
                    child: TextButton(
                      key: Key("registerButton"),
                      onPressed: () {
                        if(formkey.currentState!.validate()){
                          registration(context);
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => LoginPage()),
                          // );
                        }
                      },
                      child: Text(
                        "Register",
                        style: const TextStyle(fontSize: 22, color: Colors.white, height: 1.5),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical:15, horizontal:0 ),
                  child: Container(
                    height: 60,
                    width: 400,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Colors.blue[900],
                    ),
                    child: TextButton(
                      key: Key("gobackButton"),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginPage()),
                        );

                      },
                      child: Text(
                        "Go Back",
                        style: const TextStyle(fontSize: 22, color: Colors.white, height: 1.5),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
