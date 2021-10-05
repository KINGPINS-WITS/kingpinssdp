import 'package:kingpinssdp/products/books.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('testing homepage widgets', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: AllPersonData(),
    ));
  });
  //  group('log In ...', () {
  //   test('returns Successful call completes successfully', () async {
  //     final client = MockClient1();
  //     when(client.get(Uri.parse(
  //             'https://lamp.ms.wits.ac.za/home/s2280727/viewAll.php')))
  //         .thenAnswer((_) async => http.Response('Invalid login details!',
  //             200)); //((_) async => http.Response('Invalid login details!', 404));
  //     expect(await allPerson(),
  //         "Successful");
  //   });

  //   test('return Unsuccessful if the http call completes with an error',
  //       () async {
  //     final client = MockClient();
  //     Res.res = Future<http.Response>.value(
  //         http.Response("Invalid login details!", 404));
  //     when(client.post(
  //             Uri.parse('https://jsonplaceholder.typicode.com/albums/1')))
  //         .thenAnswer((_) async => http.Response('Not Found', 404));
  //     expect(await login("address@gmail.com", "password", client),
  //         "Unsuccessful");
  //   });
  // });
}
