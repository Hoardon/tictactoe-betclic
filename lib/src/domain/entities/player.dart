import 'package:flutter/material.dart';

enum Player { none, X, O }

extension PlayerProperties on Player {
  Color get color {
    switch (this) {
      case Player.none:
        return Colors.blueGrey;
      case Player.X:
        return Colors.red.shade400;
      case Player.O:
        return Colors.blue.shade400;
    }
  }

  Color get surface {
    switch (this) {
      case Player.none:
        return Colors.blueGrey;
      case Player.X:
        return Colors.red.shade100;
      case Player.O:
        return Colors.blue.shade100;
    }
  }

  IconData get iconData {
    switch (this) {
      case Player.none:
        return Icons.circle;
      case Player.X:
        return Icons.close;
      case Player.O:
        return Icons.circle_outlined;
    }
  }
}