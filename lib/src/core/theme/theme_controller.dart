import 'package:flutter/material.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_controller.g.dart';

@riverpod
class ThemeController extends _$ThemeController {
  final Duration _debounceDuration = const Duration(milliseconds: 500);
  DateTime _lastToggleTimestamp = DateTime.now();

  @override
  ThemeMode build() => ThemeMode.dark;

  void toggleTheme() {
    final now = DateTime.now();

    if (now.difference(_lastToggleTimestamp) > _debounceDuration) {
      state = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
      _lastToggleTimestamp = now;
    }
  }
}
