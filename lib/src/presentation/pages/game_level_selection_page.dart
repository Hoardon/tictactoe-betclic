import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tictactoebetclic/src/domain/ai/ai_strategy_provider.dart';
import 'package:tictactoebetclic/src/domain/entities/player.dart';
import 'package:tictactoebetclic/src/domain/states/game_notifier.dart';
import 'package:tictactoebetclic/src/presentation/widgets/call_to_action_button_widget.dart';
import 'package:tictactoebetclic/src/presentation/widgets/scaffold_animated_gradient.dart';

class GameLevelSelectionPage extends StatelessWidget {
  const GameLevelSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ScaffoldAnimatedGradient(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Choose your fate',
              style: theme.textTheme.headlineSmall?.copyWith(
                color: theme.colorScheme.secondary,
              ),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            const PlayButtons(),
            const SizedBox(height: 60),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class PlayButtons extends ConsumerWidget {
  const PlayButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Column(
      spacing: 16,
      children: [
        Text(
          'Human opponent',
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.secondary,
          ),
          textAlign: TextAlign.center,
        ),
        CtaButton(
          onPressed: () {
            ref.read(gameProvider.notifier).deactivateAI();
            context.push('/home/game');
          },
          icon: Icons.people_outline,
          label: 'Play vs Friend',
        ),
        const SizedBox(height: 8,),
        Text(
          'AI opponent',
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.secondary,
          ),
          textAlign: TextAlign.center,
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
