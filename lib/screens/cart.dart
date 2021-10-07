import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kingpinssdp/current_user.dart';

class Cart extends StatefulWidget {
  @override
  _Cart createState() => _Cart();
}

class _Cart extends State<Cart> {
  Future loadCart(String buyerEmail) async {
    var url = "https://lamp.ms.wits.ac.za/home/s2280727/kingpins/load_cart.php?buyerEmail=$buyerEmail";
    var response = await http.get(Uri.parse(url));
    
    // AsyncSnapshot<dynamic> a;
    try{
      return json.decode(response.body);
    }on FormatException{
      return Null;
    }
  }

  @override
  void initState() {
    super.initState();
    loadCart(CurrentUser.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CART'),
      ),
      body: FutureBuilder(
        initialData: [],
        future: loadCart(CurrentUser.email),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return (snapshot.hasData && snapshot.data!=Null)
              ? GridView.builder(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: (3 / 2),
                  ),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    List list = snapshot.data;
                    return Container(
                      // width: 130,
                      // height: 300,
                      padding: EdgeInsets.only(right: 10.0, left: 10.0),
                      width: MediaQuery.of(context).size.width - 10.0,
                      height: MediaQuery.of(context).size.height - 20.0,
                      
                      child: _buildCard(
                          list[index]['description'],
                          "R " + list[index]['price'],
                          list[index]['image'],
                          list[index]['id'],
                          context
                      ),
                    );
                  })
              : Center(
                  child: Text("Nothing in cart!",
                        style: TextStyle(
                        color: Colors.blue,
                        fontFamily: 'Varela',
                        fontSize: 25.0)),
                );
          // }
        },
      ),
    );
  }
}

Widget _buildCard(String name, String price, String imgPath, String prodId, context) {
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

                Text(price,
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
