import 'package:flutter_test/flutter_test.dart';
import 'package:tictactoebetclic/src/domain/entities/game_state.dart';
import 'package:tictactoebetclic/src/domain/entities/player.dart';

void main() {
  group('GameState', () {
    test('should have correct default values when created', () {
      const gameState = GameState();

      expect(
        gameState.board,
        equals(List.filled(9, Player.none)),
        reason: 'Board should be a list of 9 Player.none',
      );
      expect(
        gameState.currentPlayer,
        equals(Player.X),
        reason: 'Current player should default to Player.X',
      );
      expect(
        gameState.isGameOver,
        isFalse,
        reason: 'isGameOver should default to false',
      );
      expect(
        gameState.winner,
        isNull,
        reason: 'Winner should default to null',
      );
    });

    test('copyWith should create a new instance with updated values', () {
      const initialState = GameState();

      final newBoard = [
        Player.X, Player.none, Player.none,
        Player.O, Player.none, Player.none,
        Player.none, Player.none, Player.none,
      ];

      final updatedState = initialState.copyWith(
        board: newBoard,
        currentPlayer: Player.O,
        isGameOver: true,
        winner: Player.X,
      );

      expect(updatedState.board, equals(newBoard));
      expect(updatedState.currentPlayer, equals(Player.O));
      expect(updatedState.isGameOver, isTrue);
      expect(updatedState.winner, equals(Player.X));

      expect(initialState.board, isNot(equals(newBoard)));
      expect(initialState.currentPlayer, equals(Player.X));
    });

    test('copyWith should work for a single property', () {
      const initial_state = GameState();

      final updatedState = initial_state.copyWith(isGameOver: true);

      expect(updatedState.isGameOver, isTrue);
      expect(updatedState.board, equals(List.filled(9, Player.none)));
      expect(updatedState.currentPlayer, equals(Player.X));
      expect(updatedState.winner, isNull);
    });

    test('two instances with the same values should be equal', () {
      const state1 = GameState(
        currentPlayer: Player.O,
        isGameOver: false,
      );
      const state2 = GameState(
        currentPlayer: Player.O,
        isGameOver: false,
      );

      expect(state1, equals(state2));
      expect(state1.hashCode, equals(state2.hashCode));
    });

    test('two instances with different values should not be equal', () {
      const state1 = GameState(isGameOver: false);
      const state2 = GameState(isGameOver: true);

      expect(state1, isNot(equals(state2)));
    });
  });
}
