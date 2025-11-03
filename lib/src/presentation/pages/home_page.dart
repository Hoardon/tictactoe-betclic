import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tictactoebetclic/src/domain/states/game_notifier.dart';
import 'package:tictactoebetclic/src/domain/states/user_game_history_notifier.dart';
import 'package:tictactoebetclic/src/presentation/widgets/brightness_button_widget.dart';
import 'package:tictactoebetclic/src/presentation/widgets/call_to_action_button_widget.dart';
import 'package:tictactoebetclic/src/presentation/widgets/scaffold_animated_gradient.dart';
import 'package:tictactoebetclic/src/presentation/widgets/user_history_card_widget.dart';
import 'package:tictactoebetclic/src/presentation/widgets/user_score_card_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldAnimatedGradient(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: const [BrightnessButton()],
      ),
      body: const Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GameTitle(),
            SizedBox(height: 24),
            Expanded(child: HistoryView()),
            SizedBox(height: 24),
            PlayButton(),
          ],
        ),
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

class HistoryView extends ConsumerWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userHistory = ref.watch(userGameHistoryProvider);

    return Column(
      spacing: 24,
      children: [
        UserScoreCard(
          wins: userHistory.wins,
          losses: userHistory.losses,
          draws: userHistory.draws,
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: Theme.of(
                context,
              ).colorScheme.surface.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListView.separated(
              padding: EdgeInsets.zero,
              itemCount: userHistory.recordGameList.length,
              itemBuilder: (context, index) => UserHistoryCard(
                recordGame: userHistory.recordGameList[index],
              ),
              separatorBuilder: (context, index) => const SizedBox(height: 2),
            ),
          ),
        ),
      ],
    );
  }
}

class PlayButton extends ConsumerWidget {
  const PlayButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CtaButton(
      onPressed: () {
        ref.read(gameProvider.notifier).deactivateAI();
        context.push('/home/levels');
      },
      icon: Icons.local_play_outlined,
      label: 'Start a game',
    );
  }
}
