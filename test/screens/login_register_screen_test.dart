import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:snapbit/screens/login_screen.dart';
import 'package:snapbit/screens/register_screen.dart';

void main() {
  group('LoginScreen Widget Tests', () {
    testWidgets('Forgot password button has no hover overlay color', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: LoginScreen()));

      final forgotPasswordButton = find.text('Forgot password?');
      expect(forgotPasswordButton, findsOneWidget);

      final textButton = tester.widget<TextButton>(find.ancestor(of: forgotPasswordButton, matching: find.byType(TextButton)));
      final style = textButton.style;
      expect(style?.overlayColor?.resolve({WidgetState.hovered}), Colors.transparent);
    });

    testWidgets('Email and Password TextFields show entered text', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: LoginScreen()));

      final emailField = find.byType(TextField).at(0);
      final passwordField = find.byType(TextField).at(1);

      await tester.enterText(emailField, 'test@example.com');
      await tester.enterText(passwordField, 'password123');

      expect(find.text('test@example.com'), findsOneWidget);
      expect(find.text('password123'), findsOneWidget);
    });

    testWidgets('Register screen checkbox exists and toggles', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: RegisterScreen()));

      final checkboxFinder = find.byType(Checkbox);
      final labelFinder = find.text('I Agree with Terms of Service and Private Policy');

      expect(checkboxFinder, findsOneWidget);
      expect(labelFinder, findsOneWidget);

      Checkbox checkbox = tester.widget(checkboxFinder);
      expect(checkbox.value, isFalse);

      await tester.tap(checkboxFinder);
      await tester.pump();

      checkbox = tester.widget(checkboxFinder);
      expect(checkbox.value, isTrue);
    });

    testWidgets('Register screen forgot password button has no hover overlay color', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: RegisterScreen()));

      final forgotPasswordButton = find.text('Forgot password?');
      expect(forgotPasswordButton, findsOneWidget);

      final textButton = tester.widget<TextButton>(find.ancestor(of: forgotPasswordButton, matching: find.byType(TextButton)));
      final style = textButton.style;
      expect(style?.overlayColor?.resolve({WidgetState.hovered}), Colors.transparent);
    });

    testWidgets('Login screen "account." text has fontWeight w600', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: LoginScreen()));

      final accountText = find.text('account.');
      expect(accountText, findsOneWidget);

      final textWidget = tester.widget<Text>(accountText);
      expect(textWidget.style?.fontWeight, FontWeight.w600);
    });
  });
}
