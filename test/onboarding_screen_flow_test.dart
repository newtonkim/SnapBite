import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:snapbit/onboarding/onboarding_screen_flow.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('OnboardingScreenFlow first page shows spinner then image, others show content', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: OnboardingScreenFlow()));

    // Initially, spinner should be shown on first page
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.byType(Image), findsNothing);

    // Wait for 2 seconds to simulate loading
    await tester.pump(const Duration(seconds: 2));

    // Spinner should disappear, image should be shown
    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.byType(Image), findsOneWidget);

    // Title and description should be empty on first page
    // Since title and description are empty strings, they won't be rendered as Text widgets
    // So we check that no Text widgets with non-empty strings are found
    expect(find.byType(Text), findsNothing);

    // Swipe to next page
    await tester.fling(find.byType(PageView), const Offset(-400, 0), 1000);
    await tester.pumpAndSettle();

    // On second page, spinner should not be shown
    expect(find.byType(CircularProgressIndicator), findsNothing);

    // Title and description should be shown for second page
    expect(find.text('We serve incomparable delicacies'), findsOneWidget);
    expect(find.textContaining('All the best restaurants'), findsOneWidget);
  });

  tearDown(() {
    // No direct method to cancel timers, so no-op here
  });
}
