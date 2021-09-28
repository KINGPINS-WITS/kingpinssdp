import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kingpinssdp/Services/mentorship.dart';
import 'package:kingpinssdp/Services/tutor.dart';
import 'package:kingpinssdp/products/books.dart';
import 'package:kingpinssdp/screens/profile.dart';

import 'Services/repair.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  //late TabController tabController;
  /*
  var scaffoldKey = GlobalKey<ScaffoldState>();

  late double screenHeight;
  late double screenWidth;
  late double topPadding;
  late double bottomPadding;
//this is a list of catergoty items
  List<ContentView> contentViews = [
    ContentView(
      tab: CustomTab(title: 'PRODUCTS'),
      content: Center(
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
                  onPressed: () {},
                  child: Text(
                    'STATIONERY',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),

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
                  onPressed: () {},
                  child: Text(
                    'PERIPHERALS',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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

                  },
                  child: Text(
                    'BOOKS',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  // padding: EdgeInsets.only(right: 25, left: 25),
                )),
          ]),
          Container(
            height: 400,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/products1.jpg"), fit: BoxFit.fill),
            ),
          ),
        ],
      )),
    ),
    ContentView(
      tab: CustomTab(title: 'SERVICES'),
      content: Center(
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
                  onPressed: () {},
                  child: Text(
                    'BOOK A TUTOR',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                  onPressed: () {},
                  child: Text(
                    'LAPTOP REPAIR',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                  onPressed: () {},
                  child: Text(
                    'MENTORSHIP',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
    ),

  ];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: contentViews.length, vsync: this);
  }

  Widget desktopView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTabBar(
            controller: tabController,
            tabs: contentViews.map((e) => e.tab).toList()),
        Container(
          height: screenHeight * 0.75,
          child: TabBarView(
            controller: tabController,
            children: contentViews.map((e) => e.content).toList(),
          ),
        )
      ],
    );
  }

  Widget mobileView() {
    return Padding(
      padding:
          EdgeInsets.only(left: screenWidth * 0.05, right: screenWidth * 0.05),
      child: Container(
        width: screenWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
                iconSize: screenWidth * 0.08,
                icon: Icon(Icons.menu_rounded),
                color: Colors.black,
                onPressed: () => scaffoldKey.currentState!.openEndDrawer())
          ],
        ),
      ),
    );
  }

  Widget drawer() {
    return Drawer(
      child: ListView(
        children: [Container(height: screenHeight * 0.1)] +
            contentViews
                .map((e) => Container(
                      child: ListTile(
                        title: Text(e.tab.title),
                        onTap: () {},
                      ),
                    ))
                .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    topPadding = screenHeight * 0.05;
    bottomPadding = screenHeight * 0.01;

    print(screenWidth);
    return Scaffold(
      backgroundColor: Colors.white,
      key: scaffoldKey,
      endDrawer: drawer(),
      body: Padding(
        padding: EdgeInsets.only(top: topPadding, bottom: bottomPadding),
        child: LayoutBuilder(builder: (context, constraints) {
          if (constraints.maxWidth > 715) {
            return desktopView();
          } else {
            return mobileView();
          }
        }),
      ),
    );
  }
  */
  late TabController _controller;
  int _selectedIndex = 0;

  List<Widget> list = [
    Tab(text: "PRODUCTS"),
    Tab(text: "SERVICES"),
    Tab(text: "PROFILE"),
    Tab(text: "CART"),
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
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(
                Icons.person,
              ),
              onPressed: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProfilePage()),
                );
              }
            )
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
                          onPressed: () {},
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
                          onPressed: () {},
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
                                builder: (context) => AllPersonData(),
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Repairing(),
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
                              builder: (context) => Mentoring(),
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
                          TextSpan(text: 'This is a platform for students to be able to collaborate to be able to purchase textbooks and provide services to students. StuMarket’s main goal is to make it easy for students to find and buy textbooks and should be able to see a list of textbooks they might want to buy. They should be able to find the textbooks in the category in which the textbooks are in. StuMarket also provides student services.', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 25)),

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
