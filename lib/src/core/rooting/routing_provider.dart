import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoebetclic/src/presentation/pages/game_level_selection_page.dart';
import 'package:tictactoebetclic/src/presentation/pages/home_page.dart';
import 'package:tictactoebetclic/src/presentation/pages/game_page.dart';

part 'routing_provider.g.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

@Riverpod(keepAlive: true)
GoRouter router(Ref ref) => GoRouter(
  initialLocation: '/home',
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: '/home',
      pageBuilder: (context, state) =>
          NoTransitionPage(key: state.pageKey, child: const HomePage()),
      routes: [
        GoRoute(
          path: 'levels',
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: const GameLevelSelectionPage(),
          ),
        ),
        GoRoute(
          path: 'game',
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: const GamePage(),
          ),
        ),
      ],
    ),
  ],
);
