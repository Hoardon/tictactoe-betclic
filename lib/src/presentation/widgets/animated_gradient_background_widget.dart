import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tictactoebetclic/src/core/theme/theme_controller.dart';

class AnimatedGradientBackground extends HookConsumerWidget {
  const AnimatedGradientBackground({super.key});

  static const List<List<Color>> _lightColorSets = [
    [Color(0xFF89F7FE), Color(0xFF66A6FF)], // Aqua → Sky Blue
    [Color(0xFFFFC3A0), Color(0xFFFFAFBD)], // Peach → Pink
    [Color(0xFFB7F8DB), Color(0xFF50A7C2)], // Mint → Teal Blue
    [Color(0xFFFFE29F), Color(0xFFFF719A)], // Soft Yellow → Pink Coral
    [Color(0xFFA1FFCE), Color(0xFFFAD0C4)], // Mint Green → Pale Peach
  ];

  static const List<List<Color>> _darkColorSets = [
    [Color(0xFF373B44), Color(0xFF4286F4)], // Charcoal → Blue Glow
    [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)], // Deep Teal layers
    [Color(0xFF1F1C2C), Color(0xFF928DAB)], // Deep Purple → Misty Gray
    [Color(0xFF41295A), Color(0xFF2F0743)], // Violet → Plum
    [Color(0xFF000428), Color(0xFF004E92)], // Midnight → Royal Blue
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useAnimationController(
      duration: const Duration(seconds: 10),
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
