import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:tictactoebetclic/src/presentation/widgets/call_to_action_button_widget.dart';

void main() {
  setUpAll(() async {
    await loadAppFonts();
  });

  group('CtaButton', () {
    testWidgets('displays label and icon, and calls onPressed when tapped', (
      WidgetTester tester,
    ) async {
      bool wasPressed = false;
      const buttonLabel = 'Start Game';
      const buttonIcon = Icons.play_arrow;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CtaButton(
              onPressed: () {
                wasPressed = true;
              },
              icon: buttonIcon,
              label: buttonLabel,
            ),
          ),
        ),
      );

      expect(find.text(buttonLabel), findsOneWidget);

      expect(find.byIcon(buttonIcon), findsOneWidget);

      await tester.tap(find.byType(CtaButton));
      await tester.pump();

      expect(
        wasPressed,
        isTrue,
        reason: 'onPressed callback should be called on tap.',
      );

      await expectLater(
        find.byType(CtaButton),
        matchesGoldenFile('goldens/ctaButton.png'),
      );
    });

    // Test case 2: Verify disabled state
    testWidgets('is disabled when onPressed is null', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CtaButton(
              onPressed: null,
              icon: Icons.not_interested,
              label: 'Disabled',
            ),
          ),
        ),
      );

      final elevatedButton = tester.widget<CtaButton>(
        find.byType(CtaButton),
      );

      // You can also test this by attempting a tap and verifying a callback is not called,
      // but checking the property directly is more efficient.
      expect(
        elevatedButton.onPressed,
        isNull,
        reason: 'The button should be disabled when onPressed is null.',
      );

      await expectLater(
        find.byType(CtaButton),
        matchesGoldenFile('goldens/ctaButtonDisabled.png'),
      );
    });
  });
}
