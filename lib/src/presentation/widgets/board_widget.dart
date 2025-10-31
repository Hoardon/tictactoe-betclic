import 'package:flutter/material.dart';
import 'package:tictactoebetclic/src/domain/entities/player.dart';

class BoardWidget extends StatelessWidget {
  const BoardWidget({required this.board, required this.onCellTap, super.key});

  final List<Player> board;
  final void Function(int) onCellTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: board.length,
      itemBuilder: (context, index) {
        final player = board[index];

        final isEmpty = player == Player.none;
        final colorScheme = theme.colorScheme;

        final tileColor = isEmpty
            ? colorScheme.surfaceContainerHighest.withValues(alpha: 0.8)
            : player.surface.withValues(alpha: 0.3);

        final borderColor = isEmpty
            ? colorScheme.outlineVariant
            : player.color.withValues(alpha: 0.3);

        final shadowColor = isEmpty
            ? Colors.black.withValues(alpha: 0.2)
            : player.color.withValues(alpha: 0.4);

        return GestureDetector(
          onTap: () => onCellTap(index),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: tileColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(width: 1.2, color: borderColor),
              boxShadow: [
                BoxShadow(
                  color: shadowColor,
                  blurRadius: 6,
                  spreadRadius: 1,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Icon(
                player.iconData,
                key: ValueKey(player),
                size: isEmpty ? 10 : 60,
                color: player.color,
              ),
            ),
          ),
        );
      },
    );
  }
}
