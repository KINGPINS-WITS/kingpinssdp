// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../current_user.dart';


class ReceiptPage extends StatefulWidget{
  final String jsonCartitems;
  final double totalDue;
  const ReceiptPage({Key? key, required this.jsonCartitems, required this.totalDue}) : super(key: key);
  @override
  ReceiptPageState createState() => ReceiptPageState();
}

Future review(String message, String receiver, String proId, String rate) async{
  String buyer = CurrentUser.email;
  var url =
      "https://lamp.ms.wits.ac.za/home/s2280727/kingpins/review.php";
  var response = await http.post(Uri.parse(url), body: {
    "buyer": buyer,
    "review": message,
    "seller": receiver,
    "id": proId,
    "rate": rate,
  });
  print(response.body);
}
TextEditingController textReview= TextEditingController();

class ReceiptPageState extends State<ReceiptPage>{
  double rating=0;
  List data = [];
  double totalDue = 0;
  @override
  void initState() {
    super.initState();
    data = json.decode(widget.jsonCartitems);
    totalDue = widget.totalDue;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction Complete.     Total = R $totalDue'),
      ),
      body: ListView.builder(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          itemCount: data.length,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.grey[200],
              ),
              padding: EdgeInsets.only(right: 20.0, left: 20.0, top: 10.0, bottom: 10.0),
              margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 5.0, bottom: 5.0),
              width: MediaQuery.of(context).size.width*0.85,
              height: MediaQuery.of(context).size.height/10,
              //child: getRow(data[index]["description"], data[index]["price"]),
              child: Row(
                children: [
                  Text(data[index]["description"]+",",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(data[index]["price"],
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width*0.25,),
                  FlatButton(onPressed: (){
                    showDialog(context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Review the product/Service"),

                            content: Column(
                              children: [
                                RatingBar.builder(
                                    minRating: 1,
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (rating){
                                      this.rating= rating;
                                    }
                                ),
                                SizedBox(height: 32,),
                                TextField(
                                  controller: textReview,
                                  decoration: InputDecoration(
                                    hintText: "write your review",

                                  ),
                                ),
                                SizedBox(height: 32,),
                              ],
                            ),

                            actions: [
                              FlatButton(onPressed: (){
                                Navigator.pop(context);
                              },
                                  child: Text("Cancel")),
                              FlatButton(onPressed: (){
                                if(textReview.text==""){
                                  Fluttertoast.showToast(
                                    msg: "please write your review",
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.CENTER,
                                    fontSize: 16.0,
                                  );
                                }
                                else{
                                  review(textReview.text,data[index]["seller"],(data[index]["id"]),rating.toString());
                                  Fluttertoast.showToast(
                                    msg: "success",
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.CENTER,
                                    fontSize: 16.0,
                                  );
                                }

                              },
                                  child: Text("Submit"))
                            ],
                          );
                        });
                  },
                    child: Text("review",
                      style: TextStyle(
                          color: Colors.blue
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }

}

Widget getRow(String name, String price){
  return Text("$name, R $price",
      style: TextStyle(
          color: Colors.black,
          fontFamily: 'Varela',
          fontSize: 20.0));
}



