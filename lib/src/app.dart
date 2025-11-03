import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tictactoebetclic/src/core/rooting/routing_provider.dart';
import 'package:tictactoebetclic/src/core/theme/dark_theme.dart';
import 'package:tictactoebetclic/src/core/theme/light_theme.dart';
import 'package:tictactoebetclic/src/core/theme/theme_controller.dart';
import 'package:tictactoebetclic/src/domain/states/user_game_history_notifier.dart';

class TicTacToeApp extends ConsumerWidget {
  const TicTacToeApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final ThemeMode themeMode = ref.watch(themeControllerProvider);
    final ThemeData themeData = themeMode == ThemeMode.dark
        ? darkTheme
        : lightTheme;

    // Watch user history all along the app usage.
    ref.watch(userGameHistoryProvider);

    return MaterialApp.router(
      title: 'TicTacToe Betclic',
      routerConfig: router,
      theme: themeData,
      darkTheme: themeData,
      themeMode: themeMode,
    );
  }
}