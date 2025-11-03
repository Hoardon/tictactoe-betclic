import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:tictactoebetclic/firebase_options.dart';

class FirebaseService {
  static Future<void> initializeFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  static Future<void> recordFlutterFatalError(
    FlutterErrorDetails errorDetails,
  ) async =>
      await FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);

  static Future<void> recordError(Object error, StackTrace stack) async {
    await FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
  }
}
