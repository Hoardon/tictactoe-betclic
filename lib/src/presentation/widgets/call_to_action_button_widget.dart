import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tictactoebetclic/src/core/theme/theme_controller.dart';

enum CtaStyle { primary, secondary }

/// A stylish, theme-aware Call-to-Action button that is optimized for Riverpod.
/// It directly watches a theme provider to rebuild and adapt its colors
/// without requiring the parent widget to rebuild.
class CtaButton extends HookConsumerWidget {
  const CtaButton({
    required this.onPressed,
    required this.icon,
    required this.label,
    super.key,
  }) : style = CtaStyle.primary;

  const CtaButton.secondary({
    required this.onPressed,
    required this.icon,
    required this.label,
    super.key,
  }) : style = CtaStyle.secondary;

  final VoidCallback? onPressed;
  final IconData icon;
  final String label;
  final CtaStyle style;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeControllerProvider);
    final isDarkMode = themeMode == ThemeMode.dark;

    final colorScheme = Theme.of(context).colorScheme;
    final isEnabled = onPressed != null;

    List<Color> gradientColors;
    Color? shadowColor;
    Color textColor;
    Border? border;

    if (!isEnabled) {
      gradientColors = switch (style) {
        CtaStyle.primary => [Colors.grey.shade500, Colors.grey.shade600],
        CtaStyle.secondary => [Colors.grey.shade300, Colors.grey.shade400],
      };
      shadowColor = null;
      textColor = Colors.white70;
    }

    gradientColors = switch (style) {
      CtaStyle.primary => [colorScheme.primary, colorScheme.secondary],
      CtaStyle.secondary => [
        colorScheme.primary.withValues(alpha: 0.4),
        colorScheme.secondary.withValues(alpha: 0.4),
      ],
    };
    shadowColor = colorScheme.primary.withValues(alpha: isDarkMode ? 0.4 : 0.3);
    textColor = colorScheme.onPrimary;

    border = switch (style) {
      CtaStyle.primary => null,
      CtaStyle.secondary => Border.all(
        color: Theme.of(context).colorScheme.primary,
        width: 2,
      ),
    };

    return _CtaWidget(
      onPressed: onPressed,
      icon: icon,
      label: label,
      gradientColors: gradientColors,
      shadowColor: shadowColor,
      textColor: textColor,
      border: border,
    );
  }
}

class _CtaWidget extends StatelessWidget {
  const _CtaWidget({
    required this.onPressed,
    required this.icon,
    required this.label,
    required this.gradientColors,
    required this.shadowColor,
    required this.textColor,
    required this.border,
  });

  final VoidCallback? onPressed;
  final IconData icon;
  final String label;
  final List<Color> gradientColors;
  final Color? shadowColor;
  final Color? textColor;
  final Border? border;

  @override
  Widget build(BuildContext context) {
    final Color? shadow = shadowColor;

    return Container(
      width: double.infinity,
      height: 64,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        border: border,
        boxShadow: shadow != null
            ? [
                BoxShadow(
                  color: shadow,
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
                  Icon(icon, size: 28, color: textColor),
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
