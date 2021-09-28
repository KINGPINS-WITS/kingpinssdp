import 'package:http/http.dart' as http;
import 'package:kingpinssdp/screens/login_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'login_function_test.mocks.dart';

void main() {
  group('log In ...', () {
    test('returns Successful call completes successfully', () async {
      final client = MockClient();
      when(client.post(Uri.parse('https://lamp.ms.wits.ac.za/home/s2280727/kingpins/login.php'))).thenAnswer((_) async => http.Response('Invalid login details!', 200));//((_) async => http.Response('Invalid login details!', 404));
      expect(await login("thapelo@wits.ac.za", "12345678", client), "Successful");
    });

    test('return Unsuccessful if the http call completes with an error', () async{
      final client = MockClient();
      Res.res = Future<http.Response>.value(http.Response("Invalid login details!",404));
      when(client.post(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'))).thenAnswer((_) async => http.Response('Not Found', 404));
      expect(await login("address@gmail.com", "password", client), "Unsuccessful");
    });
  });
}