import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tictactoebetclic/src/core/theme/theme_controller.dart';

class BrightnessButton extends ConsumerWidget {
  const BrightnessButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeControllerProvider);
    return MaterialButton(
      onPressed: () => ref.read(themeControllerProvider.notifier).toggleTheme(),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(
            opacity: animation,
            child: RotationTransition(turns: animation, child: child),
          );
        },
        child: themeMode == ThemeMode.light
            ? const Icon(Icons.brightness_2_outlined, key: ValueKey<bool>(true))
            : const Icon(
                Icons.brightness_1_outlined,
                key: ValueKey<bool>(false),
              ),
      ),
    );
  }
}
