import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tictactoebetclic/src/core/theme/theme_controller.dart';
import 'package:tictactoebetclic/src/presentation/widgets/animated_gradient_background_widget.dart';

void main() {
  // Helper to find the Container and get its decoration for inspection
  BoxDecoration getGradientDecoration(WidgetTester tester) {
    final container = tester.widget<Container>(find.byType(Container));
    return container.decoration as BoxDecoration;
  }

  group('AnimatedGradientBackground Widget Test', () {
    testWidgets('should display the initial dark theme gradient', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: AnimatedGradientBackground(),
            ),
          ),
        ),
      );
      await tester.pump();

      final decoration = getGradientDecoration(tester);
      final gradient = decoration.gradient as LinearGradient;

      final expectedBeginColor = Colors.indigo.shade900;
      final expectedEndColor = Colors.purple.shade900;

      expect(gradient.colors[0], expectedBeginColor);
      expect(gradient.colors[1], expectedEndColor);
    });

    testWidgets('should switch to the light theme gradient when the theme is toggled', (WidgetTester tester) async {
      final container = ProviderContainer();

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: const MaterialApp(
            home: Scaffold(
              body: AnimatedGradientBackground(),
            ),
          ),
        ),
      );
      await tester.pump();

      var decoration = getGradientDecoration(tester);
      var gradient = decoration.gradient as LinearGradient;
      expect(gradient.colors[0], Colors.indigo.shade900);

      container.read(themeControllerProvider.notifier).toggleTheme();
      await tester.pump();

      decoration = getGradientDecoration(tester);
      gradient = decoration.gradient as LinearGradient;

      final expectedBeginColor = Colors.blue.shade200;
      final expectedEndColor = Colors.purple.shade200;

      expect(gradient.colors[0], expectedBeginColor);
      expect(gradient.colors[1], expectedEndColor);
    });
  });
}
