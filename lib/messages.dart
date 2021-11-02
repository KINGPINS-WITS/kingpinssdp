import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:kingpinssdp/current_user.dart';
import 'package:kingpinssdp/products/books.dart';

class Messeges extends StatefulWidget {
  @override
  _MessegesState createState() => _MessegesState();
}

TextEditingController reply = TextEditingController();

class _MessegesState extends State<Messeges> {
  Future allPerson() async {
    var url = "https://lamp.ms.wits.ac.za/home/s2280727/viewAll2.php";
    var response = await http.post(Uri.parse(url), body: {
      "RECEIVER": CurrentUser.email,
    });
    return json.decode(response.body);
  }

  @override
  void initState() {
    super.initState();
    allPerson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Messages"),
      ),
      body: FutureBuilder(
        future: allPerson(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          int i = 0;
          return snapshot.hasData
              ? GridView.builder(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    childAspectRatio: (1 / 0.1),
                  ),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    List list = snapshot.data;

                    return Card(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            leading: Icon(Icons.album),
                            title: Text(list[index]['SENDER']),
                            subtitle: Text(list[index]['MESSAGE']),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              TextButton(
                                child: const Text('reply'),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text("Send a message"),
                                          content: TextField(
                                            controller: reply,
                                            decoration: InputDecoration(
                                              hintText: "message text",
                                            ),
                                          ),
                                          actions: [
                                            FlatButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text("Cancel")),
                                            FlatButton(
                                                onPressed: () {
                                                  if (reply.text == "") {
                                                    Fluttertoast.showToast(
                                                      msg:
                                                          "Enter the message you trynna send",
                                                      toastLength:
                                                          Toast.LENGTH_LONG,
                                                      gravity:
                                                          ToastGravity.CENTER,
                                                      fontSize: 16.0,
                                                    );
                                                  } else if (list[index]
                                                          ['SENDER'] ==
                                                      CurrentUser.email) {
                                                    Fluttertoast.showToast(
                                                      msg:
                                                          "You can't send yourself a message",
                                                      toastLength:
                                                          Toast.LENGTH_LONG,
                                                      gravity:
                                                          ToastGravity.CENTER,
                                                      fontSize: 16.0,
                                                    );
                                                  } else {
                                                    sendMessage(reply.text,
                                                        list[index]['SENDER']);
                                                    Fluttertoast.showToast(
                                                      msg: "message sent",
                                                      toastLength:
                                                          Toast.LENGTH_LONG,
                                                      gravity:
                                                          ToastGravity.CENTER,
                                                      fontSize: 16.0,
                                                    );
                                                    Navigator.pop(context);
                                                  }
                                                },
                                                child: Text("Send"))
                                          ],
                                        );
                                      });
                                },
                              ),
                              const SizedBox(width: 8),
                            ],
                          ),
                        ],
                      ),
                    );
                  })
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}
