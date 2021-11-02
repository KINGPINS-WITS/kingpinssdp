import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:kingpinssdp/current_user.dart';
import 'package:kingpinssdp/products/books.dart';

class Reviews extends StatefulWidget {
  String? proId, proName, proPrice, proImage, proSeller;
  Reviews(proId, proImage, proName, proPrice, proSeller) {
    this.proId = proId;
    this.proImage = proImage;
    this.proName = proName;
    this.proPrice = proPrice;
    this.proSeller = proSeller;
  }

  @override
  _ReviewsState createState() =>
      _ReviewsState(proId!, proImage!, proName!, proPrice!, proSeller!);
}

TextEditingController reply = TextEditingController();

class _ReviewsState extends State<Reviews> {
  String? proId, proName, proPrice, proImage, proSeller;
  double rate = 0, total = 1;
  _ReviewsState(String proId, String proImage, String proName, String proPrice,
      String proSeller) {
    this.proId = proId;
    this.proImage = proImage;
    this.proName = proName;
    this.proPrice = proPrice;
    this.proSeller = proSeller;
  }
  Future<String> addToCart(String id, String seller) async {
    String buyer = CurrentUser.email;
    var url =
        "https://lamp.ms.wits.ac.za/home/s2280727/kingpins/add_to_cart.php?buyerEmail=$buyer&sellerEmail=$seller&productId=$id";
    var response = await http.get(Uri.parse(url));
    return response.body;
  }

  Future allPerson() async {
    var url = "https://lamp.ms.wits.ac.za/home/s2280727/viewAll3.php";
    var response = await http.post(Uri.parse(url), body: {
      "productId": proId!,
    });
    return json.decode(response.body);
  }

  @override
  void initState() {
    super.initState();
    allPerson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(proName!),
        ),
        body: ListView(children: [
          Hero(
              tag: proImage!,
              child: Image.network(proImage!,
                  height: 250.0, width: 200.0, fit: BoxFit.contain)),
          SizedBox(height: 20.0),
          Center(
              child: Text(proPrice!,
                  style: TextStyle(
                      fontFamily: 'Varela',
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue))),
          SizedBox(height: 10.0),
          Center(
            child: Text(proName!,
                style: TextStyle(
                    color: Colors.blue, fontFamily: 'Varela', fontSize: 24.0)),
          ),
          TextButton(
            child: const Text('Add To Cart'),
            onPressed: () {
              //print(proId!);

              addToCart(proId!, proSeller!).then((value) =>
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(value))));
            },
          ),
          TextButton(
            child: const Text('Update rating'),
            onPressed: () {
              if (total != 0) {
                setState(() {
                  rate = rate / total;
                });
              }
            },
          ),
          Center(
              child: RatingBarIndicator(
            rating: rate,
            itemBuilder: (context, index) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
            itemCount: 5,
            itemSize: 50.0,
            //direction: Axis.horizontal,
          )),
          SizedBox(height: 20.0),
          FutureBuilder(
            future: allPerson(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) print(snapshot.error);
              int i = 0;
              return snapshot.hasData
                  ? GridView.builder(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        childAspectRatio: (1 / 0.1),
                      ),
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        List list = snapshot.data;
                        //for (int i = 0; i < snapshot.data.length; i++) {
                        rate += double.parse(list[index]['RATING']);
                        // print();
                        //}
                        //rate = rate /
                        //;
                        total = snapshot.data.length;

                        return Card(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                leading: Icon(Icons.album),
                                title: Text(list[index]['buyer']),
                                subtitle: Text(list[index]['COMMENT']),
                              ),
                            ],
                          ),
                        );
                      })
                  : Center(
                      child: CircularProgressIndicator(),
                    );
            },
          ),
        ]));
  }
}
