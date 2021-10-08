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
      body:Column(
          children: [
            SizedBox(height: 30,),
            Container(
              height: 450,
              width: 350,
              margin: EdgeInsets.only(left: 29),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Stack(
                children: [
                  Positioned(
                      child: Material(
                      child: Container(
                      height: 180,
                      decoration: BoxDecoration(
                        color: Colors.blue[900],
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            offset: new Offset(-10.0, 10.0),
                            blurRadius: 20,
                            spreadRadius: 4.0,
                          )
                        ]
                      ),
                    ),
                  )),
                  Positioned(
                    top: 0,
                      child: Card(
                        elevation: 10,
                        shadowColor: Colors.grey.withOpacity(0.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Container(
                          height: 200,
                          width: 150,
                          child: Image.network(Product.image,
                          ),
                          ),
                        ),
                      ),
                  Positioned(
                    top: 35,
                      left: 160,
                      child: Container(
                        height: 150,
                        width: 180,
                        child: Column(
                          children: [
                              Text(Product.name,
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              ),
                            Text("R "+Product.price,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            Divider(color: Colors.grey,),
                            Text("sold by: "+Product.seller,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ))
                ],
              ),
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


