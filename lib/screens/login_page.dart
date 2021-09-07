// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:kingpinssdp/current_user.dart';
import 'package:kingpinssdp/signup.dart';

import '../homepage.dart';

class LoginPage extends StatefulWidget{
  const LoginPage({Key? key}) : super(key: key);
  @override
  LoginPageState createState() => LoginPageState();
}


class LoginPageState extends State<LoginPage>{

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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

  Future<String> login(String email, String password) async {

    var url = "https://lamp.ms.wits.ac.za/home/s2280727/kingpins/login.php?email=$email&password=$password";
    final res = await http.post(
      Uri.parse(url),
      );
    
    var response = res.body;
    if(response != "Invalid login details!"){
      var userDetails = jsonDecode(response);
      CurrentUser.email = userDetails["email"];
      CurrentUser.firstName = userDetails["firstname"];
      CurrentUser.lastName = userDetails["lastname"];
      CurrentUser.funds = userDetails["funds"];
      CurrentUser.image = userDetails["image"];

      // goto homepage
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HomePage()),
      );
      return "Successful";
    }
  
    _showMyDialog();
    return "Unsuccessful";
    
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
                    'StuMarket',
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
                                key: Key("LoginButton"),
                                onPressed: () {
                                  if(formkey.currentState!.validate()){
                                    login(emailController.text,passwordController.text);
                                  }
                                },
                                child: Text(
                                  "Log In",
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
                          key: Key("signupButton"),
                          onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignupPage()),
                              );

                          },
                          child: Text(
                            "Sign Up",
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
                          color: Colors.grey!.withOpacity(0.3),
                        ),
                        child: TextButton(

                          key: Key("LoginButton"),
                          onPressed: () {
                            GoogleSignIn().signIn();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()),
                            );
                          },
                          child: Text(
                            "Sign in with Google",
                            style: const TextStyle(fontSize: 22, color: Colors.black87, height: 1.5),
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
