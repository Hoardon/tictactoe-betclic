import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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
                PlayButton(),
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

class PlayButton extends ConsumerWidget {
  const PlayButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return
      CtaButton(
        onPressed: () {
          ref.read(gameProvider.notifier).deactivateAI();
          context.push('/home/levels');
        },
        icon: Icons.local_play_outlined,
        label: 'Start a game',
      );
  }
}
