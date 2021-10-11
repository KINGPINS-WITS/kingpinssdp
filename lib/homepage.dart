import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:kingpinssdp/Services/mentorship.dart';
import 'package:kingpinssdp/Services/tutor.dart';
import 'package:kingpinssdp/products/books.dart';
import 'package:kingpinssdp/screens/profile.dart';
import 'package:kingpinssdp/screens/cart.dart';
import 'package:kingpinssdp/screens/searchResults.dart';

import 'Services/repair.dart';
import 'classes/product.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  int _selectedIndex = 0;

  TextEditingController searchController = TextEditingController();

  Future search() async {
    var url = "https://lamp.ms.wits.ac.za/home/s2280727/search.php";
    var response = await http.post(Uri.parse(url), body: {
      "find": searchController.text,
    });
    var res = jsonDecode(response.body);
    Product.name = res["description"];
    Product.image = res["image"];
    Product.price = res["price"];
    Product.seller = res["seller"];

    print(Product.image);
  }

  List<Widget> list = [
    Tab(text: "PRODUCTS"),
    Tab(text: "SERVICES"),
    Tab(text: "ABOUT US"),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Create TabController for getting the index of current tab
    _controller = TabController(length: list.length, vsync: this);

    _controller.addListener(() {
      setState(() {
        _selectedIndex = _controller.index;
      });
      print("Selected Index: " + _controller.index.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("STUMARKET"),
          actions: [
            Container(
              width: 250,
              decoration: BoxDecoration(
                color: Colors.grey[400]!.withOpacity(0.5),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: TextFormField(
                  key: Key("LastNameField"),
                  controller: searchController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: IconButton(
                          icon: Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            search();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => searchResults()),
                            );
                          }),
                    ),
                    hintText: "search",
                    hintStyle: TextStyle(
                      color: Colors.white60,
                    ),
                  ),
                  obscureText: false,
                  style: TextStyle(color: Colors.white60),
                  keyboardType: TextInputType.text,
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Cart()),
                );
              },
            ),
            IconButton(
                icon: Icon(
                  Icons.person,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()),
                  );
                })
          ],
          bottom: new PreferredSize(
            preferredSize: new Size(600.0, 30.0),
            child: new Container(
              width: 600.0,
              child: new TabBar(
                controller: _controller,
                tabs: list,
              ),
            ),
          ),
        ),
        body: TabBarView(
          controller: _controller,
          children: [
            Center(
              child: Center(
                  child: Column(
                children: [
                  Row(children: [
                    SizedBox(
                      height: 50,
                      width: 180,
                    ),
                    Container(
                        decoration: BoxDecoration(
                          border: Border(
                              right: BorderSide(
                            //                   <--- left side
                            color: Color.fromARGB(256, 26, 35, 16),
                            width: 1.5,
                          )),
                        ),
                        child: FlatButton(
                          color: Colors.grey[350],
                          focusColor: Colors.blue,
                          hoverColor: Colors.blue,
                          splashColor: Colors.blue,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    AllPersonData("STATIONERY"),
                              ),
                            );
                          },
                          child: Text(
                            'STATIONERY',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          // padding: EdgeInsets.only(right: 25, left: 25),
                        )),
                    Container(
                        decoration: BoxDecoration(
                          border: Border(
                              right: BorderSide(
                            //                   <--- left side
                            color: Color.fromARGB(256, 26, 35, 16),
                            width: 1.5,
                          )),
                        ),
                        child: FlatButton(
                          color: Colors.grey[350],
                          focusColor: Colors.blue,
                          hoverColor: Colors.blue,
                          splashColor: Colors.blue,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    AllPersonData("PERIPHERALS"),
                              ),
                            );
                          },
                          child: Text(
                            'PERIPHERALS',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          //  padding: EdgeInsets.only(right: 25, left: 25),
                        )),
                    Container(
                        decoration: BoxDecoration(),
                        child: FlatButton(
                          color: Colors.grey[350],
                          focusColor: Colors.blue,
                          hoverColor: Colors.blue,
                          splashColor: Colors.blue,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AllPersonData("BOOKS"),
                              ),
                            );
                          },
                          child: Text(
                            'BOOKS',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          // padding: EdgeInsets.only(right: 25, left: 25),
                        )),
                  ]),
                  Container(
                    height: 400,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/products1.jpg"),
                          fit: BoxFit.fill),
                    ),
                  ),
                ],
              )),
            ),
            Center(
                child: Column(
              children: [
                Row(children: [
                  SizedBox(
                    height: 50,
                    width: 200,
                  ),
                  Container(
                      decoration: BoxDecoration(
                        border: Border(
                            right: BorderSide(
                          //                   <--- left side
                          color: Color.fromARGB(256, 26, 35, 16),
                          width: 1.5,
                        )),
                      ),
                      child: FlatButton(
                        color: Colors.grey[350],
                        focusColor: Colors.blue,
                        hoverColor: Colors.blue,
                        splashColor: Colors.blue,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Tutoring(),
                            ),
                          );
                        },
                        child: Text(
                          'BOOK A TUTOR',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        padding: EdgeInsets.only(right: 25, left: 25),
                      )),
                  Container(
                      decoration: BoxDecoration(
                        border: Border(
                            right: BorderSide(
                          //                   <--- left side
                          color: Color.fromARGB(256, 26, 35, 16),
                          width: 1.5,
                        )),
                      ),
                      child: FlatButton(
                        color: Colors.grey[350],
                        focusColor: Colors.blue,
                        hoverColor: Colors.blue,
                        splashColor: Colors.blue,
                        onPressed: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => Repairing(),
                          //   ),
                          // );
                        },
                        child: Text(
                          'LAPTOP REPAIRS',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        padding: EdgeInsets.only(right: 25, left: 25),
                      )),
                  Container(
                      decoration: BoxDecoration(
                        border: Border(
                            right: BorderSide(
                          //                   <--- left side
                          color: Color.fromARGB(256, 26, 35, 16),
                          width: 1.5,
                        )),
                      ),
                      child: FlatButton(
                        color: Colors.grey[350],
                        focusColor: Colors.blue,
                        hoverColor: Colors.blue,
                        splashColor: Colors.blue,
                        onPressed: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => Mentoring(),
                          //   ),
                          // );
                        },
                        child: Text(
                          'MENTORSHIP',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        padding: EdgeInsets.only(right: 25, left: 25),
                      )),
                ]),
                Container(
                  height: 400,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("services1.png"), fit: BoxFit.fill),
                  ),
                ),
              ],
            )),
            Center(
                child: Column(
              children: [
                Row(children: [
                  SizedBox(
                    height: 50,
                    width: 200,
                  ),
                ]),
                RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: const <TextSpan>[
                      TextSpan(
                          text:
                              'This is a platform for students to be able to collaborate to be able to purchase textbooks and provide services to students. StuMarket’s main goal is to make it easy for students to find and buy textbooks and should be able to see a list of textbooks they might want to buy. They should be able to find the textbooks in the category in which the textbooks are in. StuMarket also provides student services.',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 25)),
                    ],
                  ),
                )
              ],
            )),
          ],
        ),
      ),
    );
  }
}
