import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tictactoebetclic/src/core/theme/dark_theme.dart';
import 'package:tictactoebetclic/src/core/theme/light_theme.dart';
import 'package:tictactoebetclic/src/presentation/widgets/call_to_action_button_widget.dart';

void main() {

  setUpAll(() async {
    await loadAppFonts();
  });

  Widget buildTestableWidget(Widget button) {
    return ProviderScope(
      child: MaterialApp(
        theme: darkTheme,
        home: Scaffold(body: button),
      ),
    );
  }

  group('CtaButton', () {
    testWidgets('Primary button renders correctly in enabled state', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        buildTestableWidget(
          CtaButton(onPressed: () {}, icon: Icons.check, label: 'Primary'),
        ),
      );

      final ctaWidget = tester.widget<CtaWidget>(find.byType(CtaWidget));
      final container = tester.widget<Container>(find.byType(Container).first);
      final decoration = container.decoration as BoxDecoration;

      expect(ctaWidget.onPressed, isNotNull);
      expect(ctaWidget.label, 'Primary');
      expect(decoration.border, isNull);
      expect(decoration.boxShadow, isNotNull);

      await expectLater(
        find.byType(CtaButton),
        matchesGoldenFile('goldens/cta.png'),
      );
    });

    testWidgets('Secondary button renders correctly in enabled state', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        buildTestableWidget(
          CtaButton.secondary(
            onPressed: () {},
            icon: Icons.close,
            label: 'Secondary',
          ),
        ),
      );

      final ctaWidget = tester.widget<CtaWidget>(find.byType(CtaWidget));
      final container = tester.widget<Container>(find.byType(Container).first);
      final decoration = container.decoration as BoxDecoration;

      expect(ctaWidget.onPressed, isNotNull);
      expect(ctaWidget.label, 'Secondary');
      expect(decoration.border, isNotNull);
      expect(decoration.boxShadow, isNotNull);

      await expectLater(
        find.byType(CtaButton),
        matchesGoldenFile('goldens/ctaSecondary.png'),
      );
    });

    testWidgets('Primary button renders correctly in disabled state', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        buildTestableWidget(
          const CtaButton(
            onPressed: null, // Disables the button
            icon: Icons.check,
            label: 'Disabled',
          ),
        ),
      );

      final ctaWidget = tester.widget<CtaWidget>(find.byType(CtaWidget));

      expect(ctaWidget.onPressed, isNull);

      await expectLater(
        find.byType(CtaButton),
        matchesGoldenFile('goldens/ctaDisable.png'),
      );
    });

    testWidgets('Button correctly display light', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            theme: lightTheme,
            home: Scaffold(
              body: CtaButton(
                onPressed: () {},
                icon: Icons.color_lens,
                label: 'Theme Light',
              ),
            ),
          ),
        ),
      );

      await expectLater(
        find.byType(CtaButton),
        matchesGoldenFile('goldens/ctaLight.png'),
      );
    });

    testWidgets('Button correctly display dark', (
        WidgetTester tester,
        ) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            theme: darkTheme,
            home: Scaffold(
              body: CtaButton(
                onPressed: () {},
                icon: Icons.color_lens,
                label: 'Theme Dark',
              ),
            ),
          ),
        ),
      );

      await expectLater(
        find.byType(CtaButton),
        matchesGoldenFile('goldens/ctaDark.png'),
      );
    });
  });
}
