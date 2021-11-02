import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kingpinssdp/screens/profile.dart';
import '../current_user.dart';
import 'package:http/http.dart' as http;

import '../homepage.dart';

class Addfunds extends StatefulWidget {
  const Addfunds({Key? key}) : super(key: key);

  @override
  AddfundsState createState() => AddfundsState();
}

class AddfundsState extends State<Addfunds> {
  void res() {
    String str1 = CurrentUser.funds;
    String str2 = amount.text;
    var num1 = num.tryParse(str1);
    var num2 = num.tryParse(str2);
    num ans = 0;
    if (num2 != null && num1 != null) {
      ans = (num1 + num2);
    }
    setState(() {
      CurrentUser.funds = "$ans";
    });
  }

  //checks if a enter value is numeric
  bool isNumeric(String string) {
    // Null or empty string is not a number
    if (string == null || string.isEmpty) {
      return false;
    }
    final number = num.tryParse(string);

    if (number == null) {
      return false;
    }

    return true;
  }

  //http request
  Future addFunds(BuildContext context) async {
    var url = "https://lamp.ms.wits.ac.za/home/s2280727/kingpins/add_funds.php";
    var response = await http.post(Uri.parse(url), body: {
      "email": CurrentUser.email,
      "funds": amount.text,
    });
    res();
    Fluttertoast.showToast(
      msg: "SUCCESS",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      fontSize: 16.0,
    );

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfilePage()),
    );

    // if (data == "Balance Updated") {

    // } else {
    //   Fluttertoast.showToast(
    //     msg: "failed",
    //     toastLength: Toast.LENGTH_SHORT,
    //     gravity: ToastGravity.CENTER,
    //     fontSize: 16.0,
    //   );
    // }
  }

  TextEditingController amount = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('StuMarket'),
      ),
      body: Column(
        children: [
          Container(
            height: 40,
            child: Center(
              child: Text(
                "BALANCE",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
            ),
          ),
          Container(
            height: 40,
            child: Center(
              child: Text(
                "R " + CurrentUser.funds,
                style: TextStyle(
                  color: Colors.blue[900],
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 400,
            width: MediaQuery.of(context).size.width * 0.5,
            decoration: BoxDecoration(
              color: Colors.blue[900],
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  "ADD FUNDS",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Easiest way to add funds to your StuMarket account",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  width: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xFFC6C0C0)!.withOpacity(0.5),
                  ),
                  child: Center(
                    child: TextFormField(
                      key: Key("FirstNameField"),
                      controller: amount,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "enter amount",
                        hintStyle: TextStyle(
                            fontSize: 15, color: Colors.white70, height: 1.5),
                      ),
                      obscureText: false,
                      style: TextStyle(
                          fontSize: 22, color: Colors.white70, height: 1.5),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15, horizontal: 0),
                  child: Container(
                    height: 60,
                    width: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Colors.white,
                    ),
                    child: TextButton(
                      key: Key("LoginButton"),
                      onPressed: () {
                        if (isNumeric(amount.text)) {
                          addFunds(context);
                        } else {
                          Fluttertoast.showToast(
                            msg: "invalid input",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            fontSize: 16.0,
                          );
                        }
                      },
                      child: Text(
                        "ADD FUNDS",
                        style: TextStyle(
                            fontSize: 18, color: Colors.blue[900], height: 1.5),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
