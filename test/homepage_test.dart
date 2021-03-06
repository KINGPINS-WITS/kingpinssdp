 import 'package:flutter/material.dart';
 import 'package:flutter_test/flutter_test.dart';
 import 'package:kingpinssdp/homepage.dart';

 void main() {
  testWidgets('testing homepage widgets', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
       home: HomePage(),
     ));
     var proTitle = find.text("PRODUCTS");
     expect(proTitle, findsOneWidget);

     var serTitle = find.text("SERVICES");
     expect(serTitle, findsOneWidget);

    var abTitle = find.text("ABOUT US");
    expect(abTitle, findsOneWidget);

     var pro1 = find.text("BOOKS");
     expect(pro1, findsOneWidget);

     var pro2 = find.text("STATIONERY");
     expect(pro2, findsOneWidget);

     var pro3 = find.text("PERIPHERALS");
     expect(pro3, findsOneWidget);

     var ser1 = find.text("BOOK A TUTOR");
     expect(pro1, findsOneWidget);

     var ser2 = find.text("LAPTOP REPAIR");
     expect(pro2, findsOneWidget);

     var ser3 = find.text("MENTORSHIP");
     expect(pro3, findsOneWidget);
   });
 }
