import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tictactoebetclic/src/core/theme/dark_theme.dart';
import 'package:tictactoebetclic/src/core/theme/light_theme.dart';
import 'package:tictactoebetclic/src/core/theme/theme_controller.dart';
import 'package:tictactoebetclic/src/presentation/widgets/brightness_button_widget.dart';

void main() {

  group('BrightnessButton Tests', () {
    testWidgets('should render a brightness button light', (widgetTester) async {
      await loadAppFonts();

      await widgetTester.pumpWidget(
        ProviderScope(overrides: [
          themeControllerProvider.overrideWithValue(ThemeMode.light),
        ], child: MaterialApp(theme: lightTheme, home: const BrightnessButton())),
      );
      await widgetTester.pumpAndSettle();

      expect(find.byType(BrightnessButton), findsOneWidget);

      await expectLater(
        find.byType(BrightnessButton),
        matchesGoldenFile('goldens/brightnessButtonLight.png'),
      );
    });

    testWidgets('should render a brightness button dark', (widgetTester) async {
      await loadAppFonts();

      await widgetTester.pumpWidget(
        ProviderScope(overrides: [
          themeControllerProvider.overrideWithValue(ThemeMode.dark),
        ], child: MaterialApp(theme: darkTheme, home: const BrightnessButton())),
      );
      await widgetTester.pumpAndSettle();

      expect(find.byType(BrightnessButton), findsOneWidget);

      await expectLater(
        find.byType(BrightnessButton),
        matchesGoldenFile('goldens/brightnessButtonDark.png'),
      );
    });
  });
}
