import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kingpinssdp/Services/tutor.dart';
import 'package:kingpinssdp/current_user.dart';
import 'package:kingpinssdp/screens/rate.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AllPersonData extends StatefulWidget {
  String? _cat;
  AllPersonData(String cat) {
    this._cat = cat;
  }
  @override
  _AllPersonDataState createState() => _AllPersonDataState(_cat!);
}

Future sendMessage(String message, String receiver) async{
  String sender = CurrentUser.email;
  var url =
      "https://lamp.ms.wits.ac.za/home/s2280727/kingpins/sendtext.php";
  var response = await http.post(Uri.parse(url), body: {
    "sender": sender,
    "message": message,
    "receiver": receiver,
  });
  //print(response.body);
}
TextEditingController message= TextEditingController();
class _AllPersonDataState extends State<AllPersonData> {
  String? _cat;
  _AllPersonDataState(String cat) {
    this._cat = cat;
  }
  Future<String> addToCart(String id, String seller) async {
    String buyer = CurrentUser.email;
    var url =
        "https://lamp.ms.wits.ac.za/home/s2280727/kingpins/add_to_cart.php?buyerEmail=$buyer&sellerEmail=$seller&productId=$id";
    var response = await http.get(Uri.parse(url));
    return response.body;
  }



  Future allPerson() async {
    var url = "https://lamp.ms.wits.ac.za/home/s2280727/viewAll.php";
    var response = await http.post(Uri.parse(url), body: {
      "category": _cat,
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
        title: Text(_cat!),
      ),
      body: FutureBuilder(
        initialData: [],
        future: allPerson(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          //
          return snapshot.hasData
              ? GridView.builder(
              physics: ScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: (3 / 3),
              ),
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                List list = snapshot.data;

                return Container(
                  // width: 130,
                  // height: 300,
                  padding: EdgeInsets.only(right: 10.0),
                  width: MediaQuery.of(context).size.width - 10.0,
                  height: MediaQuery.of(context).size.height - 20.0,

                  child: _buildCard(
                      list[index]['id'],
                      list[index]['seller'],
                      list[index]['description'],
                      "R" + list[index]['price'],
                      list[index]['image'],
                      false,
                      false,
                      context),
                );
              })
              : Center(
            child: CircularProgressIndicator(),
          );
          // }
        },
      ),
    );
  }
}

Widget _buildCard(String id, String seller, String name, String price,
    String imgPath, bool added, bool isFavorite, context) {
  return Padding(
      padding: EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 0),
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
                Container(
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
                                          controller: message,
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
                                            if(message.text == "" ){
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
                                              sendMessage(message.text, seller);
                                            }
                                          },
                                              child: Text("Send"))
                                        ],
                                      );
                                    });
                              }
                          )
                        ])),
                SizedBox(
                  height: 20,
                ),
                Center(
                    child: Container(
                        height: 150.0,
                        width: 130.0,
                        child: Image.network(imgPath))),
                Text(price,
                    style: TextStyle(
                        color: Colors.blue,
                        fontFamily: 'Varela',
                        fontSize: 14.0)),
                Text(name,
                    style: TextStyle(
                        color: Colors.blue,
                        fontFamily: 'Varela',
                        fontSize: 14.0)),
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
                                color: Colors.green, size: 12.0),
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
                              onTap: () {
                                addToCart(id, seller).then((value) =>
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(value))));
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
                              onTap: () {
                                addToCart(id, seller).then((value) =>
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(value))));
                              },
                            ),
                          ]
                        ]))
              ]))));
}
