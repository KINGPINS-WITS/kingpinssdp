
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing/rectangle.dart';
import 'package:mockito/mockito.dart';

class MockDio extends Mock implements Dio {}

void main() {
  test('Get area given lenght and breadth', () async {
    // ARRANGE
    // This is how you could mock something
    // final mockDio = MockDio();
    // when(mockDio.get(any)).thenAnswer((invocation) => Future.value(Response()));

    final rect = Rectangle(4, 5);

    // ACT
    int a = rect.get_area();

    // ASSERT
    expect(a, 20);
  });
}