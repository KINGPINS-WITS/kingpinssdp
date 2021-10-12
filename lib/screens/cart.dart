import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kingpinssdp/current_user.dart';
import 'package:kingpinssdp/screens/receipt.dart';

class Cart extends StatefulWidget {
  @override
  _Cart createState() => _Cart();
}

Future<String> doCheckout(String jsonString) async {
  String buyer = CurrentUser.email;
  var url = "https://lamp.ms.wits.ac.za/home/s2280727/kingpins/checkout.php?buyerEmail=$buyer&jsonString=$jsonString";
  var response = await http.get(Uri.parse(url));
  return response.body;
}

class _Cart extends State<Cart> {
  String jsonString = "";
  double totalDue = 0;
  Future loadCart(String buyerEmail) async {
    var url = "https://lamp.ms.wits.ac.za/home/s2280727/kingpins/load_cart.php?buyerEmail=$buyerEmail";
    var response = await http.get(Uri.parse(url));
    
    jsonString = response.body;
    try{
      return json.decode(response.body);
    }on FormatException{
      return Null;
    }
  }

  @override
  void initState() {
    super.initState();
    totalDue = 0;
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
                    totalDue += double.parse(list[index]['price']);
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
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Checkout"),
        icon: const Icon(Icons.double_arrow_sharp),
        backgroundColor: Colors.blue,
        onPressed: (){
          if(double.parse(CurrentUser.funds) >= totalDue){
            doCheckout(jsonString).then((value){
              if(value=="Cart cleared."){
                double newFunds = (double.parse(CurrentUser.funds) - totalDue);
                CurrentUser.funds = newFunds.toString();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ReceiptPage(jsonCartitems: jsonString, totalDue: totalDue,)),
                );
              }
              else{
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value)));
              }
            });
          }
          else{
            String bal = CurrentUser.funds;
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("You do not have enough funds. Your funds are R $bal, Items Cost R $totalDue")));
          }
          
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
                        child: (imgPath!="no") ? Image.network(imgPath):Image.asset('servicePic.jpg'))),

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
