import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tictactoebetclic/src/presentation/widgets/brightness_button_widget.dart';

void main() {
  Widget createTestableWidget() {
    return const MaterialApp(home: BrightnessButton());
  }

  group('BrightnessButton Tests', () {
    testWidgets('should render a brightness button', (widgetTester) async {
      await loadAppFonts();

      await widgetTester.pumpWidget(
        ProviderScope(child: createTestableWidget()),
      );
      await widgetTester.pumpAndSettle();

      expect(find.byType(BrightnessButton), findsOneWidget);

      await expectLater(
        find.byType(BrightnessButton),
        matchesGoldenFile('goldens/brightnessButtonLight.png'),
      );

      await widgetTester.tap(find.byType(BrightnessButton));
      await widgetTester.pumpAndSettle();

      await expectLater(
        find.byType(BrightnessButton),
        matchesGoldenFile('goldens/brightnessButtonDark.png'),
      );
    });
  });
}
