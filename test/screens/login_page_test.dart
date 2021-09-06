import 'package:kingpinssdp/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('login page ...', (tester) async {
    // setup
    final email = find.byKey(ValueKey("EmailField"));
    final password = find.byKey(ValueKey("PasswordField"));
    final loginButton = find.byKey(ValueKey("LoginButton"));

    // execute
    await tester.pumpWidget(MaterialApp(home: LoginPage(),));
    await tester.enterText(email, "main@domain.com");
    await tester.enterText(password, "12345678");
    await tester.pump();

    // check
    expect(find.text("main@domain.com"), findsOneWidget);
    expect(find.text("12345678"), findsOneWidget);
    expect(find.text("Log In"), findsOneWidget);
  });
}