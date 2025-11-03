import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tictactoebetclic/src/core/utils/logger.dart';
import 'package:tictactoebetclic/src/services/firebase/firebase_service.dart';

/// Error handler to display error on various exceptions and errors cases.
void registerErrorHandler() {
  // Display UI error on uncaught exception
  FlutterError.onError = (FlutterErrorDetails details) {
    FirebaseService.recordFlutterFatalError(details);
    FlutterError.presentError(details);
    Log.error(details.toString());
  };
  // Handle platform and OS errors
  PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
    FirebaseService.recordError(error, stack);
    Log.error('${error.toString()} ${stack.toString()}');
    return true;
  };
  // Display UI error on widget building failure
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text('Something unexpected occurred...'),
        ),
        body: Center(child: Text(details.toString())),
      ),
    );
  };
}
