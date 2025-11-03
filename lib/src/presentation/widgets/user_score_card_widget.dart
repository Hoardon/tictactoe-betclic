import 'package:flutter/material.dart';

class UserScoreCard extends StatelessWidget {
  const UserScoreCard({
    super.key,
    required this.wins,
    required this.losses,
    required this.draws,
  });

  final int wins;
  final int losses;
  final int draws;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 0,
      color: theme.colorScheme.surface.withValues(alpha: 0.8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: _ScoreColumn(
                label: 'Wins',
                value: wins,
                icon: Icons.emoji_events, // Trophy icon
                iconColor: Colors.amber.shade700,
              ),
            ),
            Expanded(
              child: _ScoreColumn(
                label: 'Losses',
                value: losses,
                icon: Icons.thumb_down, // Thumbs down icon
                iconColor: Colors.red.shade600,
              ),
            ),
            Expanded(
              child: _ScoreColumn(
                label: 'Draws',
                value: draws,
                icon: Icons.handshake, // Handshake icon for draws
                iconColor: Colors.blue.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ScoreColumn extends StatelessWidget {
  const _ScoreColumn({
    required this.label,
    required this.value,
    required this.icon,
    required this.iconColor,
  });

  final String label;
  final int value;
  final IconData icon;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: iconColor, size: 32.0),
        const SizedBox(height: 8.0),
        FittedBox(
          child: Text(
            value.toString(),
            style: textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(height: 2.0),
        FittedBox(
          child: Text(
            label.toUpperCase(),
            style: textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
              letterSpacing: 0.8,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
