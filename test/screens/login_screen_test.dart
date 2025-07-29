import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:snapbit/screens/login_screen.dart';

void main() {
  group('LoginScreen Widget Tests', () {
    testWidgets('LoginScreen renders and _buildContactOption works', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: LoginScreen()));

      // Verify main texts
      expect(find.text('Login to your'), findsOneWidget);
      expect(find.text('account.'), findsOneWidget);
      expect(find.text('Please sign in to your account'), findsOneWidget);

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
    });
  });
}
