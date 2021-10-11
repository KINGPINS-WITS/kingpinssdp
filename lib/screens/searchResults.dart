import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kingpinssdp/classes/product.dart';
import 'package:kingpinssdp/current_user.dart';
import 'package:kingpinssdp/homepage.dart';

class searchResults extends StatefulWidget {
  const searchResults({Key? key}) : super(key: key);
  @override
  _searchResultsState createState() => _searchResultsState();
}

class _searchResultsState extends State<searchResults> {
  String name= Product.name;
  String image= Product.image;
  String price= Product.price;

  List<Book> books = [Book(Product.name,Product.price,Product.image)];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('SEARCH RESULTS'),
      ),
      body: Column(
        children: [
          SizedBox(height: 25,),
          Container(
            margin: EdgeInsets.only(left: 15),
            width: 300,
            height: 300,
            child: _buildCard(name, price, image, context),
          )

        ],

      ),
    );
  }
}

class Book{
  String name="";
  String price="";
  String image="";

  Book(String name, String price, String image){
    this.name= name;
    this.price=price;
    this.image= image;
  }
}

Widget _buildCard(String name, String price, String imgPath, context) {
  return Padding(
      padding: EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 0),
      child: InkWell(
          onTap: () {},
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 3.0,
                        blurRadius: 5.0)
                  ],
                  color: Colors.white),
              child: Column(children: [

                Container(
                    padding: EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 5),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(Icons.delete , color: Colors.red)
                        ])),
                SizedBox(
                  height: 20,
                ),
                Center(
                    child: Container(
                        height: 150.0,
                        width: 130.0,
                        child: Image.network(imgPath))),

                Text("R "+price,
                    style: TextStyle(
                        color: Colors.blue,
                        fontFamily: 'Varela',
                        fontSize: 18.0)),
                Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Container(color: Colors.blue, height: 1.0)),
                Text(name,
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Varela',
                        fontSize: 14.0)),
                // Padding(

              ]))));
}


