import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tictactoebetclic/src/domain/entities/player.dart';

void main() {
  group('PlayerProperties Extension', () {
    group('Player.X', () {
      test('should have the correct color', () {
        const player = Player.X;
        final color = player.color;
        expect(color, Colors.red.shade400);
      });

      test('should have the correct surface color', () {
        const player = Player.X;
        final surfaceColor = player.surface;
        expect(surfaceColor, Colors.red.shade100);
      });

      test('should have the correct iconData', () {
        const player = Player.X;
        final icon = player.iconData;
        expect(icon, Icons.close);
      });
    });

    group('Player.O', () {
      test('should have the correct color', () {
        const player = Player.O;
        final color = player.color;
        expect(color, Colors.blue.shade400);
      });

      test('should have the correct surface color', () {
        const player = Player.O;
        final surfaceColor = player.surface;
        expect(surfaceColor, Colors.blue.shade100);
      });

      test('should have the correct iconData', () {
        const player = Player.O;
        final icon = player.iconData;
        expect(icon, Icons.circle_outlined);
      });
    });

    group('Player.none', () {
      test('should have the correct color', () {
        const player = Player.none;
        final color = player.color;
        expect(color, Colors.blueGrey);
      });

      test('should have the correct surface color', () {
        const player = Player.none;
        final surfaceColor = player.surface;
        expect(surfaceColor, Colors.blueGrey);
      });

      test('should have the correct iconData', () {
        const player = Player.none;
        final icon = player.iconData;
        expect(icon, Icons.circle);
      });
    });
  });
}
