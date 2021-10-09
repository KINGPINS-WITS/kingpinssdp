// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables


import 'package:flutter/material.dart';
import 'package:kingpinssdp/current_user.dart';
import 'dart:math';

class ProfilePage extends StatefulWidget{
  const ProfilePage({Key? key}) : super(key: key);
  @override
  ProfilePageState createState() => ProfilePageState();
}
Widget _buildPopupDialog(BuildContext context) {
  return new AlertDialog(
    title: const Text('Upload an advert'),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Hello"),
      ],
    ),
    actions: <Widget>[
      new FlatButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        textColor: Theme.of(context).primaryColor,
        child: const Text('Close'),
      ),
    ],
  );
}

class ProfilePageState extends State<ProfilePage>{

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  String emailController = CurrentUser.email;
  String nameController = CurrentUser.lastName + " " + CurrentUser.firstName;
  String fundsController = "R " + CurrentUser.funds;
  static int picNum = new Random().nextInt(3)+1;
  String defaultPic = "$picNum.jpg";

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
                    'Profile',
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
                          child: Image.asset(defaultPic,
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
                                    style: TextStyle(fontSize: 22, color: Colors.black, height: 1.5),
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
                                    style: TextStyle(fontSize: 22, color: Colors.black, height: 1.5),
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
                                  child: Text(
                                    '$fundsController',
                                    style: TextStyle(fontSize: 22, color: Colors.black, height: 1.5),
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
                                    width:22,
                                  ),
                                  Center(

                                    child: ElevatedButton(

                                      onPressed: () {
                                        // Respond to button press
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) => _buildPopupDialog(context),
                                        );
                                      },

                                      child: Text('Upload an add'),
                                    ),
                                  ),
                                  SizedBox(
                                    width:22,
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
