import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tictactoebetclic/src/domain/entities/player.dart';
import 'package:tictactoebetclic/src/domain/states/game_notifier.dart';
import 'package:tictactoebetclic/src/presentation/widgets/board_widget.dart';
import 'package:tictactoebetclic/src/presentation/widgets/call_to_action_button_widget.dart';
import 'package:tictactoebetclic/src/presentation/widgets/scaffold_animated_gradient.dart';

class GamePage extends ConsumerWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final gameState = ref.watch(gameProvider);

    final isOver = gameState.isGameOver;
    final winner = gameState.winner;

    return ScaffoldAnimatedGradient(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
            const Spacer(flex: 2),
            BoardWidget(
              board: gameState.board,
              onCellTap: (index) =>
                  ref.read(gameProvider.notifier).makeMove(index),
            ),
            const Spacer(flex: 1),
            SizedBox(
              height: 150,
              child: isOver
                  ? Column(
                      spacing: 20,
                      children: [
                        CtaButton(
                          onPressed: ref.read(gameProvider.notifier).resetGame,
                          icon: Icons.refresh,
                          label: 'Play again',
                        ),
                        const CtaButton.secondary(
                          onPressed: null,
                          // onPressed: () {
                          //   if (context.canPop()) context.pop();
                          // },
                          icon: Icons.arrow_back,
                          label: 'Back to levels',
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
