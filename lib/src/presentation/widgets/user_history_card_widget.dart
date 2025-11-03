import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tictactoebetclic/src/domain/entities/record_game.dart';

class UserHistoryCard extends StatelessWidget {
  const UserHistoryCard({
    super.key,
    required this.recordGame,
  });

  final RecordGame recordGame;

  (IconData, Color) _getIconForStatus(RecordGameStatus status, BuildContext context) {
    return switch (status) {
      RecordGameStatus.victory => (Icons.emoji_events, Colors.amber.shade700),
      RecordGameStatus.loss    => (Icons.thumb_down, Colors.red.shade600),
      RecordGameStatus.draw    => (Icons.handshake, Colors.blue.shade600),
      RecordGameStatus.unknown => (Icons.question_mark_outlined, Colors.blue.shade600),
    };
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final (iconData, iconColor) = _getIconForStatus(recordGame.status, context);

    return Card(
      elevation: 0,
      color: theme.colorScheme.surface.withValues(alpha: 0.8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: SizedBox(
          height: 56,
          child: Row(
            children: [
              Icon(iconData, color: iconColor, size: 32.0),
              const SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recordGame.status.label,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2.0),
                    Text(
                      'VS: ${recordGame.opponent.label}',
                      style: textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16.0),
              Text(
                DateFormat('d MMM, HH:mm', Localizations.localeOf(context).toString()).format(recordGame.datetime),
                style: textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: theme.colorScheme.onSurface.withOpacity(0.8),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
