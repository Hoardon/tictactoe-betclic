import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
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
          path: 'game',
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: const GamePage(),
          ),
        ),
      ],
    ),
    // GoRoute(
    //   path: '/error-localization-disabled',
    //   pageBuilder: (context, state) =>
    //       NoTransitionPage(
    //         key: state.pageKey,
    //         child: const ErrorLocationDisabledPage(),
    //       ),
    // ),
    // StatefulShellRoute.indexedStack(
    //   builder: (context, state, navigationShell) {
    //     return NestedNavigationScreen(navigationShell: navigationShell);
    //   },
    //   branches: [
    //     StatefulShellBranch(
    //       routes: [
    //         GoRoute(
    //           path: '/home',
    //           pageBuilder: (context, state) =>
    //               NoTransitionPage(
    //                 key: state.pageKey,
    //                 child: const HomePage(),
    //               ),
    //         ),
    //       ],
    //     ),
    //     StatefulShellBranch(
    //       routes: [
    //         GoRoute(
    //           path: '/buslines',
    //           pageBuilder: (context, state) =>
    //               NoTransitionPage(
    //                 key: state.pageKey,
    //                 child: const SearchPage(),
    //               ),
    //         ),
    //       ],
    //     ),
    //     StatefulShellBranch(
    //       routes: [
    //         GoRoute(
    //           path: '/map',
    //           pageBuilder: (context, state) =>
    //               NoTransitionPage(
    //                 key: state.pageKey,
    //                 child: const MapPage(),
    //               ),
    //           routes: [
    //             GoRoute(
    //               path: 'search-itinerary',
    //               pageBuilder: (context, state) =>
    //                   CustomTransitionPage(
    //                     key: state.pageKey,
    //                     transitionDuration: const Duration(milliseconds: 300),
    //                     transitionsBuilder:
    //                         (context, animation, secondaryAnimation, child) {
    //                       return FadeTransition(
    //                         opacity: CurveTween(curve: Curves.easeInOutCirc)
    //                             .animate(animation),
    //                         child: child,
    //                       );
    //                     },
    //                     child: const SearchItineraryPage(),
    //                   ),
    //             ),
    //           ],
    //         ),
    //       ],
    //     ),
    //     StatefulShellBranch(
    //       routes: [
    //         GoRoute(
    //           path: '/menu',
    //           pageBuilder: (context, state) =>
    //               NoTransitionPage(
    //                 key: state.pageKey,
    //                 child: const MenuPage(),
    //               ),
    //         ),
    //       ],
    //     ),
    //   ],
    // ),
  ],
);
