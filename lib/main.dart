import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tictactoebetclic/src/app.dart';
import 'package:tictactoebetclic/src/core/utils/custom_provider_observer.dart';
import 'package:tictactoebetclic/src/core/utils/error_handler.dart';
import 'package:tictactoebetclic/src/services/firebase/firebase_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseService.initializeFirebase();
  registerErrorHandler();
  runApp(
    ProviderScope(
      observers: [CustomProviderObserver()],
      child: const TicTacToeApp(),
    ),
  );
}