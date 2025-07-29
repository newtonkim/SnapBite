import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:snapbit/screens/login_screen.dart';
import 'package:snapbit/screens/register_screen.dart';
import 'package:snapbit/screens/email_verification.dart';

void main() {
  group('LoginScreen Thorough Widget Tests', () {
    testWidgets('LoginScreen renders all main UI elements', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: LoginScreen()));

      // Verify main texts
      expect(find.text('Login to your'), findsOneWidget);
      expect(find.text('account.'), findsOneWidget);
      expect(find.text('Please sign in to your account'), findsOneWidget);
      expect(find.text('Email Address'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(find.text('Forgot password?'), findsOneWidget);
      expect(find.text('Sign In'), findsOneWidget);
      expect(find.text('Or sign in with'), findsOneWidget);
      expect(find.byType(TextField), findsNWidgets(2));
      expect(find.byType(ElevatedButton), findsNWidgets(2)); // Continue and Sign In buttons

      // Verify social sign-in buttons by image asset presence
      expect(find.byWidgetPredicate((widget) =>
          widget is Image && widget.image.toString().contains('google_my_choice.png')), findsOneWidget);
      expect(find.byWidgetPredicate((widget) =>
          widget is Image && widget.image.toString().contains('facebook_logo.png')), findsOneWidget);
      expect(find.byWidgetPredicate((widget) =>
          widget is Image && widget.image.toString().contains('apple_logo.png')), findsOneWidget);
    });

    testWidgets('Forgot password flow shows SnackBar with contact options and Continue button', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: LoginScreen()));

      // Tap "Forgot password?" button to show SnackBar
      final forgotPasswordButton = find.text('Forgot password?').first;
      expect(forgotPasswordButton, findsOneWidget);
      await tester.tap(forgotPasswordButton);
      await tester.pumpAndSettle();

      // Verify SnackBar content including _buildContactOption widgets
      expect(find.text('Forgot password?'), findsNWidgets(2)); // Button and SnackBar
      expect(find.text('Select which contact details should we use to reset your password'), findsOneWidget);
      expect(find.text('Send via WhatsApp'), findsOneWidget);
      expect(find.text('Send via Email'), findsOneWidget);
      expect(find.byIcon(Icons.message), findsOneWidget);
      expect(find.byIcon(Icons.email), findsOneWidget);

      // Verify Continue button in SnackBar
      final continueButton = find.widgetWithText(ElevatedButton, 'Continue');
      expect(continueButton, findsOneWidget);

      // Tap Continue button and verify navigation to EmailVerificationScreen
      await tester.tap(continueButton);
      await tester.pumpAndSettle();

      expect(find.byType(EmailVerificationScreen), findsOneWidget);
    });

    testWidgets('Sign In button is present and enabled', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: LoginScreen()));

      final signInButton = find.widgetWithText(ElevatedButton, 'Sign In');
      expect(signInButton, findsOneWidget);
      expect(tester.widget<ElevatedButton>(signInButton).enabled, true);
    });

    testWidgets('Navigation to Register screen works', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: LoginScreen()));

      final registerText = find.text('Register');
      expect(registerText, findsOneWidget);

      await tester.tap(registerText);
      await tester.pumpAndSettle();

      expect(find.byType(RegisterScreen), findsOneWidget);
    });
  });
}
