// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:kingpinssdp/current_user.dart';
import 'package:kingpinssdp/screens/upload.dart';
import 'dart:math';

import 'add_funds.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);
  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  String emailController = CurrentUser.email;
  String nameController = CurrentUser.lastName + " " + CurrentUser.firstName;
  String fundsController = "R " + CurrentUser.funds;
  static int picNum = new Random().nextInt(3) + 1;
  String defaultPic = "$picNum.jpg";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PROFILE'),
      ),
      backgroundColor: Colors.grey[50],
      body: Column(
        children: [
          Form(
            key: formkey,
            autovalidateMode: AutovalidateMode.always,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Container(
                    height: 400,
                    width: 400,
                    decoration: BoxDecoration(
                      color: Colors.grey[200]!.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: Image.asset(
                        defaultPic,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 400,
                    width: 400,
                    decoration: BoxDecoration(
                      color: Colors.grey[200]!.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 60,
                          width: 400,
                          decoration: BoxDecoration(
                            color: Colors.grey[200]!.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Center(
                            child: Text(
                              '$emailController',
                              style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.black,
                                  height: 1.5),
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
                              child: Text(
                                '$nameController',
                                style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.black,
                                    height: 1.5),
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
                              child: FlatButton(
                                focusColor: Colors.blue,
                                hoverColor: Colors.blue,
                                splashColor: Colors.blue,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Addfunds()),
                                  );
                                },
                                child: Text(
                                  '$fundsController',
                                  style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.black,
                                      height: 1.5),
                                ),
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
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 22,
                                ),
                                Center(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // // Respond to button press
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (context) =>
                                      //         DemoUploadImage(),
                                      //   ),
                                      //);
                                    },
                                    child: Text('Upload an add'),
                                  ),
                                ),
                                SizedBox(
                                  width: 22,
                                ),
                                Center(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // Respond to button press
                                    },
                                    child: Text('save'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
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
