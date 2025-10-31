import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tictactoebetclic/src/core/theme/theme_controller.dart';

class AnimatedGradientBackground extends HookConsumerWidget {
  const AnimatedGradientBackground({super.key});

  static final List<List<Color>> _lightColorSets = [
    [Colors.blue.shade200, Colors.purple.shade200],
    [Colors.cyan.shade200, Colors.pink.shade200],
    [Colors.green.shade200, Colors.yellow.shade200],
  ];

  static final List<List<Color>> _darkColorSets = [
    [Colors.indigo.shade900, Colors.purple.shade900],
    [Colors.teal.shade900, Colors.blueGrey.shade900],
    [Colors.deepPurple.shade900, Colors.pink.shade900],
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useAnimationController(
      duration: const Duration(seconds: 30),
    );

    useEffect(() {
      controller.repeat();
      return null;
    }, []);

    final themeMode = ref.watch(themeControllerProvider);
    final currentPalette =
    themeMode == ThemeMode.light ? _lightColorSets : _darkColorSets;

    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final progress = controller.value;
        final colorSetCount = currentPalette.length;

        final colorSetIndex = (progress * colorSetCount).floor();
        final nextColorSetIndex = (colorSetIndex + 1) % colorSetCount;

        final setProgress = (progress * colorSetCount) % 1.0;

        final beginColor = currentPalette[colorSetIndex][0];
        final endColor = currentPalette[nextColorSetIndex][0];

        final interpolatedColor = Color.lerp(beginColor, endColor, setProgress);

        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                interpolatedColor ?? beginColor,
                Color.lerp(
                    currentPalette[colorSetIndex][1],
                    currentPalette[nextColorSetIndex][1],
                    setProgress
                ) ?? currentPalette[colorSetIndex][1],
              ],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
          ),
        );
      },
    );
  }
}
