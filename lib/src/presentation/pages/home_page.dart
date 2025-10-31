import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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
          // 1. Animated Gradient Background
          AnimatedGradientBackground(),

          // 2. Main Content
          Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [GameTitle(), SizedBox(height: 60), PlayButtons()],
              ),
            ),
          ),

          // 3. Floating Brightness Button
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
    final theme = Theme.of(context);

    return Column(
      children: [
        CtaButton(
          onPressed: () {
            // TODO: Set AI active state to false
            // ref.read(gameProvider.notifier).setAiActive(false);

            // TODO: Navigate to your game screen
            // Navigator.of(context).push(MaterialPageRoute(builder: (_) => const GamePage()));
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Navigating to Player vs Player...'),
              ),
            );
          },
          icon: Icons.people_outline,
          label: 'Play vs Friend',
        ),
        const SizedBox(height: 20),
        CtaButton(
          onPressed: () {
            // TODO: Set AI active state to true
            // ref.read(gameProvider.notifier).setAiActive(true);

            // TODO: Navigate to your game screen
            // Navigator.of(context).push(MaterialPageRoute(builder: (_) => const GamePage()));
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Navigating to Player vs AI...')),
            );
          },
          icon: Icons.computer_outlined,
          label: 'Play vs AI',
        ),
      ],
    );
  }
}
