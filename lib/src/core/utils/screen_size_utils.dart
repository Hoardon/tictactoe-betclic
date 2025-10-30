import 'package:flutter/material.dart';

extension ScreenSize on BuildContext {
  double screenHeight() => MediaQuery.sizeOf(this).height;

  double screenWidth() => MediaQuery.sizeOf(this).width;
}