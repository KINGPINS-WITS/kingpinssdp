// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// class Repairing extends StatefulWidget {
//   @override
//   _RepairingState createState() => _RepairingState();
// }
//
// class _RepairingState extends State<Repairing> {
//   Future allPerson() async {
//     var url = "https://lamp.ms.wits.ac.za/home/s2280727/viewAll2.php";
//     var response = await http.get(Uri.parse(url));
//     return json.decode(response.body);
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     allPerson();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Repairs'),
//       ),
//       body: FutureBuilder(
//         future: allPerson(),
//         builder: (BuildContext context, AsyncSnapshot snapshot) {
//           if (snapshot.hasError) print(snapshot.error);
//           int i = 0;
//           return snapshot.hasData
//               ? GridView.builder(
//               physics: ScrollPhysics(),
//               shrinkWrap: true,
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 4,
//                 childAspectRatio: (1 / 1),
//               ),
//
//               itemCount: snapshot.data.length,
//               itemBuilder: (context, index) {
//                 List list = snapshot.data;
//
//                 return Container(
//                   // width: 130,
//                   // height: 300,
//                   padding: EdgeInsets.only(right: 10.0),
//                   width: MediaQuery.of(context).size.width - 10.0,
//                   height: MediaQuery.of(context).size.height - 20.0,
//
//                   child: _buildCard(
//                       list[index]['description'],
//                       list[index]['price'],
//                       false,
//                       false,
//                       context),
//                 );
//               })
//               : Center(
//             child: CircularProgressIndicator(),
//           );
//         },
//       ),
//     );
//   }
// }
//
// Widget _buildCard(String name, String price, bool added,
//     bool isFavorite, context) {
//   return Padding(
//       padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
//       child: InkWell(
//           onTap: () {},
//           child: Container(
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(15.0),
//                   boxShadow: [
//                     BoxShadow(
//                         color: Colors.grey.withOpacity(0.2),
//                         spreadRadius: 3.0,
//                         blurRadius: 5.0)
//                   ],
//                   color: Colors.white),
//               child: Column(children: [
//                 Padding(
//                     padding: EdgeInsets.all(5.0),
//                     child: Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           Icon(Icons.favorite_border, color: Colors.green)
//                         ])),
//
//                 Text(price,
//                     style: TextStyle(
//                         color: Colors.green,
//                         fontFamily: 'Varela',
//                         fontSize: 14.0)),
//                 Text(name,
//                     style: TextStyle(
//                         color: Colors.green,
//                         fontFamily: 'Varela',
//                         fontSize: 14.0)),
//                 Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Container(color: Colors.green, height: 1.0)),
//                 Padding(
//                     padding: EdgeInsets.only(left: 5.0, right: 5.0),
//                     child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           if (!added) ...[
//                             Icon(Icons.shopping_basket,
//                                 color: Colors.green, size: 12.0),
//                             Text('Add to cart',
//                                 style: TextStyle(
//                                     fontFamily: 'Varela',
//                                     color: Colors.green,
//                                     fontSize: 12.0))
//                           ],
//                           if (added) ...[
//                             Icon(Icons.shopping_basket,
//                                 color: Colors.green, size: 12.0),
//                             Text('Add to cart',
//                                 style: TextStyle(
//                                     fontFamily: 'Varela',
//                                     color: Colors.green,
//                                     fontSize: 12.0))
//                           ]
//                         ]))
//               ]))));
// }