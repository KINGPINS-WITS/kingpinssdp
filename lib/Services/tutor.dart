import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kingpinssdp/current_user.dart';
import 'package:kingpinssdp/screens/rate.dart';
import 'package:kingpinssdp/products/books.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Tutoring extends StatefulWidget {
  String? multiple;
  Tutoring(String multiple) {
    this.multiple = multiple;
  }
  @override
  _TutoringState createState() => _TutoringState(multiple!);
}
TextEditingController text= TextEditingController();
Future<String> addToCart(String id, String seller) async {
  String buyer = CurrentUser.email;
  var url = "https://lamp.ms.wits.ac.za/home/s2280727/kingpins/add_to_cart.php?buyerEmail=$buyer&sellerEmail=$seller&productId=$id";
  var response = await http.get(Uri.parse(url));
  return response.body;
}

class _TutoringState extends State<Tutoring> {
  String? multiple;
  _TutoringState(String multiple) {
    this.multiple = multiple;
  }
  Future allPerson() async {
    var url = "https://lamp.ms.wits.ac.za/home/s2280727/viewAll.php";
    var response = await http.post(Uri.parse(url), body: {
      "category": multiple,
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
        title: Text(multiple!),
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
                crossAxisCount: 4,
                childAspectRatio: (1/ 0.3),
              ),

              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                List list = snapshot.data;

                return Container(
                  width: 130,
                  height: 200,
                  padding: EdgeInsets.only(right: 10.0),
                  //width: MediaQuery.of(context).size.width - 10.0,
                  // height: MediaQuery.of(context).size.height - 20.0,

                  child: _buildCard(
                      list[index]['id'],
                      list[index]['seller'],
                      list[index]['description'],
                      list[index]['price'],
                      false,
                      false,
                      context),
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

Widget _buildCard(String id, String seller, String name, String price, bool added,
    bool isFavorite, context) {
  return Padding(
      padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
      child: InkWell(
          onTap: () {},
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 3.0,
                        blurRadius: 5.0)
                  ],
                  color: Colors.white),
              child: Column(children: [
                Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              icon: Icon(Icons.send,
                                  color: Colors.blue),
                              onPressed: (){
                                showDialog(context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text("Send a message"),
                                        content: TextField(
                                          controller: text,
                                          decoration: InputDecoration(
                                            hintText: "message text",

                                          ),
                                        ),
                                        actions: [
                                          FlatButton(onPressed: (){
                                            Navigator.pop(context);
                                          },
                                              child: Text("Cancel")),
                                          FlatButton(onPressed: (){
                                            if(text.text == "" ){
                                              Fluttertoast.showToast(
                                                msg: "Enter the message you trynna send",
                                                toastLength: Toast.LENGTH_LONG,
                                                gravity: ToastGravity.CENTER,
                                                fontSize: 16.0,
                                              );
                                            }
                                            else if(seller == CurrentUser.email){
                                              Fluttertoast.showToast(
                                                msg: "You can't send yourself a message",
                                                toastLength: Toast.LENGTH_LONG,
                                                gravity: ToastGravity.CENTER,
                                                fontSize: 16.0,
                                              );
                                            }
                                            else{
                                              sendMessage(text.text, seller);
                                              Fluttertoast.showToast(
                                                msg: "message sent",
                                                toastLength: Toast.LENGTH_LONG,
                                                gravity: ToastGravity.CENTER,
                                                fontSize: 16.0,
                                              );
                                              Navigator.pop(context);
                                            }

                                          },
                                              child: Text("Send"))
                                        ],
                                      );
                                    });
                              }
                          )
                        ])),

                Text(name,
                    style: TextStyle(
                        color: Colors.blue,
                        fontFamily: 'Varela',
                        fontSize: 14.0)),
                Text(price,
                    style: TextStyle(
                        color: Colors.blue,
                        fontFamily: 'Varela',
                        fontSize: 14.0)),
                Text(seller,
                    style: TextStyle(
                        color: Colors.blue,
                        fontFamily: 'Varela',
                        fontSize: 14.0)
                ),
                Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Container(color: Colors.blue, height: 1.0)),
                Padding(
                    padding: EdgeInsets.only(left: 5.0, right: 5.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          if (!added) ...[
                            Icon(Icons.shopping_basket,
                                color: Colors.blue, size: 12.0),
                            InkWell(
                              child: Text('Rate',
                                  style: TextStyle(
                                      fontFamily: 'Varela',
                                      color: Colors.blue,
                                      fontSize: 12.0
                                  )
                              ),
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Rate()
                                  ),
                                );
                              },
                            ),
                            InkWell(
                              child: Text('Add to cart',
                                  style: TextStyle(
                                      fontFamily: 'Varela',
                                      color: Colors.blue,
                                      fontSize: 12.0)),
                              onTap: (){
                                addToCart(id, seller).then((value) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value))));
                              },
                            ),
                          ],
                          if (added) ...[
                            Icon(Icons.shopping_basket,
                                color: Colors.blue, size: 12.0),
                            InkWell(
                              child: Text('Add to cart',
                                  style: TextStyle(
                                      fontFamily: 'Varela',
                                      color: Colors.blue,
                                      fontSize: 12.0)),
                              onTap: (){
                                addToCart(id, seller).then((value) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value))));
                              },
                            ),
                          ]
                        ]))
              ]))));
}
