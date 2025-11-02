import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tictactoebetclic/src/domain/ai/ai_strategy_provider.dart';
import 'package:tictactoebetclic/src/domain/entities/player.dart';
import 'package:tictactoebetclic/src/domain/states/game_notifier.dart';
import 'package:tictactoebetclic/src/presentation/widgets/animated_gradient_background_widget.dart';
import 'package:tictactoebetclic/src/presentation/widgets/brightness_button_widget.dart';
import 'package:tictactoebetclic/src/presentation/widgets/call_to_action_button_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          AnimatedGradientBackground(),
          Padding(
            padding: EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GameTitle(),
                SizedBox(height: 60),
                PlayButtons(),
              ],
            ),
          ),
          Positioned(top: 40, right: 16, child: BrightnessButton()),
        ],
      ),
    );
  }
}

class GameTitle extends StatelessWidget {
  const GameTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(
          'Tic Tac Toe',
          style: theme.textTheme.displayLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
            letterSpacing: 1.2,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          'Choose your fate',
          style: theme.textTheme.headlineSmall?.copyWith(
            color: theme.colorScheme.secondary,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class PlayButtons extends ConsumerWidget {
  const PlayButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      spacing: 20,
      children: [
        CtaButton(
          onPressed: () {
            ref.read(gameProvider.notifier).deactivateAI();
            context.push('/home/game');
          },
          icon: Icons.people_outline,
          label: 'Play vs Friend',
        ),
        CtaButton(
          onPressed: () {
            ref
                .read(gameProvider.notifier)
                .activateAI(strategy: AIStrategyEnum.easy);
            context.push('/home/game');
          },
          icon: Icons.computer_outlined,
          label: 'Play vs AI (easy 🧸)',
        ),
        CtaButton(
          onPressed: () {
            ref
                .read(gameProvider.notifier)
                .activateAI(strategy: AIStrategyEnum.medium);
            context.push('/home/game');
          },
          icon: Icons.computer_outlined,
          label: 'Play vs AI (medium 🤔)',
        ),
        CtaButton(
          onPressed: () {
            ref
                .read(gameProvider.notifier)
                .activateAI(
                  strategy: AIStrategyEnum.hard,
                  startPlayer: Player.O,
                );
            context.push('/home/game');
          },
          icon: Icons.computer_outlined,
          label: 'Play vs AI (hard 🔥)',
        ),
      ],
    );
  }
}
