// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables


import 'dart:convert';

import 'package:flutter/material.dart';


class ReceiptPage extends StatefulWidget{
  final String jsonCartitems;
  final double totalDue;
  const ReceiptPage({Key? key, required this.jsonCartitems, required this.totalDue}) : super(key: key);
  @override
  ReceiptPageState createState() => ReceiptPageState();
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
                      child: getRow(data[index]["description"], data[index]["price"]),
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
