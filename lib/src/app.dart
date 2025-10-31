import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tictactoebetclic/src/core/rooting/routing_provider.dart';
import 'package:tictactoebetclic/src/core/theme/dark_theme.dart';
import 'package:tictactoebetclic/src/core/theme/light_theme.dart';
import 'package:tictactoebetclic/src/core/theme/theme_controller.dart';

class TicTacToeApp extends ConsumerWidget {
  const TicTacToeApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final ThemeMode themeMode = ref.watch(themeControllerProvider);
    final ThemeData themeData = themeMode == ThemeMode.dark
        ? darkTheme
        : lightTheme;

    return MaterialApp.router(
      title: 'TicTacToe Betclic',
      routerConfig: router,
      theme: themeData,
      darkTheme: themeData,
      themeMode: themeMode,
    );
  }
}