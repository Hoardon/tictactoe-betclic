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

      expect(
        gameState.aiActive,
        isFalse,
        reason: 'aiActive should default to false',
      );
      expect(
        gameState.aiPlayer,
        equals(Player.O),
        reason: 'aiPlayer should default to Player.O',
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
        aiActive: true,
        aiPlayer: Player.X,
      );

      expect(updatedState.board, equals(newBoard));
      expect(updatedState.currentPlayer, equals(Player.O));
      expect(updatedState.isGameOver, isTrue);
      expect(updatedState.winner, equals(Player.X));

      expect(updatedState.aiActive, isTrue);
      expect(updatedState.aiPlayer, equals(Player.X));


      expect(initialState.board, isNot(equals(newBoard)));
      expect(initialState.currentPlayer, equals(Player.X));
      expect(initialState.aiActive, isFalse);
    });

    test('copyWith should work for a single property', () {
      const initialState = GameState();

      final updatedState1 = initialState.copyWith(isGameOver: true);
      expect(updatedState1.isGameOver, isTrue);
      expect(updatedState1.aiActive, isFalse, reason: "Other properties should be unchanged");

      final updatedState2 = initialState.copyWith(aiActive: true);
      expect(updatedState2.aiActive, isTrue);
      expect(updatedState2.isGameOver, isFalse, reason: "Other properties should be unchanged");
    });

    test('two instances with the same values should be equal', () {
      const state1 = GameState(
        currentPlayer: Player.O,
        isGameOver: false,
        aiActive: true,
        aiPlayer: Player.X,
      );
      const state2 = GameState(
        currentPlayer: Player.O,
        isGameOver: false,
        aiActive: true,
        aiPlayer: Player.X,
      );

      expect(state1, equals(state2));
      expect(state1.hashCode, equals(state2.hashCode));
    });

    test('two instances with different values should not be equal', () {
      const state1 = GameState(isGameOver: false);
      const state2 = GameState(isGameOver: true);
      expect(state1, isNot(equals(state2)));

      const state3 = GameState(aiActive: false);
      const state4 = GameState(aiActive: true);
      expect(state3, isNot(equals(state4)));

      const state5 = GameState(aiPlayer: Player.O);
      const state6 = GameState(aiPlayer: Player.X);
      expect(state5, isNot(equals(state6)));
    });
  });
}
