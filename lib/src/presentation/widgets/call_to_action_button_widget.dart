import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tictactoebetclic/src/core/theme/theme_controller.dart';

/// A stylish, theme-aware Call-to-Action button that is optimized for Riverpod.
/// It directly watches a theme provider to rebuild and adapt its colors
/// without requiring the parent widget to rebuild.
class CtaButton extends HookConsumerWidget {
  const CtaButton({
    required this.onPressed,
    required this.icon,
    required this.label,
    super.key,
  });

  final VoidCallback? onPressed;
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeControllerProvider);
    final isDarkMode = themeMode == ThemeMode.dark;

    final colorScheme = Theme.of(context).colorScheme;
    final isEnabled = onPressed != null;

    List<Color> gradientColors;
    Color? shadowColor;
    Color textColor;

    if (!isEnabled) {
      // -- Disabled State Colors --
      gradientColors = [
        Colors.grey.shade500,
        Colors.grey.shade600,
      ];
      shadowColor = null;
      textColor = Colors.white70;
    } else if (isDarkMode) {
      // -- Dark Theme Colors -- (Defined in your darkTheme's ColorScheme)
      gradientColors = [
        colorScheme.primary,   // e.g., A vibrant purple
        colorScheme.secondary, // e.g., A complementary pink or teal
      ];
      shadowColor = colorScheme.primary.withOpacity(0.4);
      textColor = colorScheme.onPrimary; // Usually white or a very light color
    } else {
      // -- Light Theme Colors -- (Defined in your lightTheme's ColorScheme)
      gradientColors = [
        colorScheme.primary,   // e.g., A bright blue
        colorScheme.secondary, // e.g., A lighter cyan or green
      ];
      shadowColor = colorScheme.primary.withOpacity(0.3);
      textColor = colorScheme.onPrimary; // A color guaranteed to be visible on the primary color
    }

    // The rest of the build method is the same, using the dynamic colors.
    return Container(
      width: double.infinity,
      height: 64,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: shadowColor != null
            ? [
          BoxShadow(
            color: shadowColor,
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ]
            : null,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(32),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    size: 28,
                    color: textColor,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    label,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
