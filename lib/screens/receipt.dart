// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables


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

Future review(String comment, String seller, int productId, int rate) async{
  String buyer = CurrentUser.email;
  var url =
      "https://lamp.ms.wits.ac.za/home/s2280727/kingpins/review.php";
  var response = await http.post(Uri.parse(url), body: {
    "buyer": buyer,
    "review": review,
    "seller": seller,
    "id": productId,
    "rate": rate,
  });
  print(response.body);
}

class ReceiptPageState extends State<ReceiptPage>{

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
                            _showRatingDialog(data[index]['seller'],data[index]['id'],);
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

  void _showRatingDialog(String seller, int id) {
    final _ratingDialog = RatingDialog(
      ratingColor: Colors.amber,
      title: 'Rating this Service/Product',
      message: 'Rating this Product/ Service and tell others what you think.'
          ' Add more description here if you want.',
      submitButton: 'Submit',
      onCancelled: () => print('cancelled'),
      onSubmitted: (response) {
        review("hi","me@gmai.com",77,2);

        /*print('rating: ${response.rating}, '
            'comment: ${response.comment}');

        if (response.rating < 3.0) {
          print('response.rating: ${response.rating}');
        } else {
          Container();
        }*/
      },
    );

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => _ratingDialog,
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
