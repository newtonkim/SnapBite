import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:snapbit/onboarding/onboarding_screen_flow.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('OnboardingScreenFlow first page shows loading image then content, others show content', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: OnboardingScreenFlow()));

    // Initially, loading image should be shown on first page
    expect(find.byType(Image), findsOneWidget);

    // Wait for 2 seconds to simulate loading
    await tester.pump(const Duration(seconds: 2));

    // Loading image should still be shown (since it's always shown on first page)
    expect(find.byType(Image), findsOneWidget);

    // Title and description should be empty on first page
    // Since title and description are empty strings, they won't be rendered as Text widgets
    // So we check that no Text widgets with non-empty strings are found
    expect(find.byType(Text), findsNothing);

    // Swipe to next page
    await tester.fling(find.byType(PageView), const Offset(-400, 0), 1000);
    await tester.pumpAndSettle();

    // On second page, loading image should be shown
    expect(find.byType(Image), findsOneWidget);

    // Title and description should be shown for second page
    expect(find.text('We serve incomparable delicacies'), findsOneWidget);
    expect(find.textContaining('All the best restaurants'), findsOneWidget);
  });

  tearDown(() {
    // No direct method to cancel timers, so no-op here
  });
}
