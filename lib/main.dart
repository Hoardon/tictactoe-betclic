import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tictactoebetclic/src/app.dart';
import 'package:tictactoebetclic/src/core/utils/custom_provider_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ProviderScope(
      observers: [CustomProviderObserver()],
      child: const TicTacToeApp(),
    ),
  );
}