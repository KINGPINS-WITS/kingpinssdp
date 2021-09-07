
import 'package:kingpinssdp/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('sign up page ...', (tester) async {
    // setup
    final firstname = find.byKey(ValueKey("FirstNameField"));
    final lastname = find.byKey(ValueKey("LastNameField"));
    final email = find.byKey(ValueKey("EmailField"));
    final password = find.byKey(ValueKey("PasswordField"));
    final loginButton = find.byKey(ValueKey("registerButton"));

    // execute
    await tester.pumpWidget(MaterialApp(home: SignupPage(),));
    await tester.enterText(firstname, "name");
    await tester.enterText(lastname, "name");
    await tester.enterText(email, "main@domain.com");
    await tester.enterText(password, "12345678");
    await tester.pump();

    // check
    expect(find.text("name"), findsOneWidget);
    expect(find.text("name"), findsOneWidget);
    expect(find.text("main@domain.com"), findsOneWidget);
    expect(find.text("12345678"), findsOneWidget);
    expect(find.text("Register"), findsOneWidget);
  });
}