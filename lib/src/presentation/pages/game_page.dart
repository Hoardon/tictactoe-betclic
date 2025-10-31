import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tictactoebetclic/src/domain/ai/ai_strategy_provider.dart';
import 'package:tictactoebetclic/src/domain/entities/player.dart';
import 'package:tictactoebetclic/src/domain/states/ai_game_state.dart';
import 'package:tictactoebetclic/src/domain/states/game_notifier.dart';
import 'package:tictactoebetclic/src/presentation/widgets/animated_gradient_background_widget.dart';
import 'package:tictactoebetclic/src/presentation/widgets/board_widget.dart';

class GamePage extends ConsumerWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final gameState = ref.watch(gameProvider);

    final isOver = gameState.isGameOver;
    final winner = gameState.winner;

    return Scaffold(
      body: Stack(
        children: [
          const AnimatedGradientBackground(),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 96, 24, 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FittedBox(
                  child: Text(
                    isOver
                        ? winner != null
                              ? '🎉 ${winner.name} wins!'
                              : '🤝 Draw!'
                        : 'Turn of player ${gameState.currentPlayer.name}',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: gameState.currentPlayer.color,
                    ),
                  ),
                ),
                BoardWidget(
                  board: gameState.board,
                  onCellTap: (index) =>
                      ref.read(gameProvider.notifier).makeMove(index),
                ),
                SizedBox(
                  height: 65,
                  child: isOver
                      ? ElevatedButton.icon(
                          icon: Padding(
                            padding: const EdgeInsets.only(right: 4.0),
                            child: Icon(
                              Icons.refresh,
                              color: theme.colorScheme.inversePrimary,
                            ),
                          ),
                          onPressed: ref.read(gameProvider.notifier).resetGame,
                          label: const Text('Restart'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: 15,
                            ),
                            textStyle: theme.textTheme.titleLarge,
                            backgroundColor: theme.colorScheme.primary,
                            foregroundColor: theme.colorScheme.onPrimary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
