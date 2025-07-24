// Basic Flutter widget test to verify app builds without errors.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:snapbit/main.dart';

void main() {
  testWidgets('App builds without errors', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp(onboardingComplete: false));
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
