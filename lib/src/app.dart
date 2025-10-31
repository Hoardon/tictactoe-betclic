import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tictactoebetclic/src/core/theme/dark_theme.dart';
import 'package:tictactoebetclic/src/core/theme/light_theme.dart';
import 'package:tictactoebetclic/src/core/theme/theme_controller.dart';
import 'package:tictactoebetclic/src/presentation/pages/home_page.dart';

class TicTacToeApp extends ConsumerWidget {
  const TicTacToeApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeMode themeMode = ref.watch(themeControllerProvider);
    final ThemeData themeData = themeMode == ThemeMode.dark
        ? darkTheme
        : lightTheme;

    return MaterialApp(
      title: 'TicTacToe Betclic',
      home: const HomePage(),
      theme: themeData,
      darkTheme: themeData,
      themeMode: themeMode,
    );
  }
}