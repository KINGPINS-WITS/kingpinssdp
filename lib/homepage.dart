import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:kingpinssdp/messages.dart';
import 'package:kingpinssdp/products/books.dart';
import 'package:kingpinssdp/screens/login_page.dart';
import 'package:kingpinssdp/screens/profile.dart';
import 'package:kingpinssdp/screens/cart.dart';
import 'package:kingpinssdp/screens/searchResults.dart';

import 'Services/tutor.dart';

import 'package:shared_preferences/shared_preferences.dart';

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
  bool contain(String query) {
    List description = [
      "CALCULAS",
      "PHYLOSOPHY",
      "HEALTHY BOOK",
      "Geography",
      "Mathematics",
      "peri",
      "REPAIR",
      "Modise"
    ];
    if (description.contains(query)) {
      return true;
    } else {
      return false;
    }
  }

  Future search() async {
    var url = "https://lamp.ms.wits.ac.za/home/s2280727/search.php";
    var response = await http.post(Uri.parse(url), body: {
      "find": searchController.text,
    });
    var res = jsonDecode(response.body);
    setState(() {
      Product.name = res["description"];
      Product.image = res["image"];
      Product.price = res["price"];
      Product.seller = res["seller"];
    });

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

  int counter = 2;

  showAlertDialog(BuildContext context) {

    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed:  () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HomePage()),
        );
      },
    );
    Widget continueButton = TextButton(
      child: Text("Yes, log off"),
      onPressed:  () async{
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.remove('email');
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext ctx) => LoginPage()));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Log off"),
      content: Text("Are you sure you want to log off?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
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
                            if (contain(searchController.text)) {
                              search();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => searchResults()),
                              );
                            } else {
                              Fluttertoast.showToast(
                                msg: "NO MATCHES FOUND",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.CENTER,
                                fontSize: 16.0,
                              );
                            }
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
                  Icons.message,
                ),
                onPressed: () {
                  setState(() {
                    counter = 0;
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Messeges()),
                  );
                }),
            // counter != 0
            //     ? new Positioned(
            //         right: 11,
            //         top: 11,
            //         child: new Container(
            //           padding: EdgeInsets.all(2),
            //           decoration: new BoxDecoration(
            //             color: Colors.red,
            //             borderRadius: BorderRadius.circular(6),
            //           ),
            //           constraints: BoxConstraints(
            //             minWidth: 14,
            //             minHeight: 14,
            //           ),
            //           child: Text(
            //             '$counter',
            //             style: TextStyle(
            //               color: Colors.white,
            //               fontSize: 8,
            //             ),
            //             textAlign: TextAlign.center,
            //           ),
            //         ),
            //       )
            //     : new Container(),
            IconButton(
                icon: Icon(
                  Icons.person,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()),
                  );
                }),
            IconButton(
                icon: Icon(
                  Icons.power_settings_new_outlined,
                ),
                onPressed: () {
                    showAlertDialog(context);
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
                            builder: (context) => Tutoring("BOOK A TUTOR"),
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Tutoring("LAPTOP REPAIRS"),
                            ),
                          );
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Tutoring("MENTORSHIP"),
                            ),
                          );
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
