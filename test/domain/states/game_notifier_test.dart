import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tictactoebetclic/src/domain/entities/game_state.dart';
import 'package:tictactoebetclic/src/domain/entities/player.dart';
import 'package:tictactoebetclic/src/domain/states/game_notifier.dart';

void main() {
  group('Game Notifier', () {
    test('should have a correct initial state', () {
      final container = ProviderContainer.test();

      final initialState = container.read(gameProvider);

      expect(initialState.board, equals(List.filled(9, Player.none)));
      expect(initialState.currentPlayer, equals(Player.X));
      expect(initialState.isGameOver, isFalse);
      expect(initialState.winner, isNull);
    });
  });

  group('makeMove', () {
    test('should update the board and switch players on a valid move', () {
      final container = ProviderContainer.test();
      const moveIndex = 0;

      container.read(gameProvider.notifier).makeMove(moveIndex);
      final stateAfterMove = container.read(gameProvider);

      expect(stateAfterMove.board[moveIndex], equals(Player.X));
      expect(stateAfterMove.currentPlayer, equals(Player.O));
      expect(stateAfterMove.isGameOver, isFalse);
      expect(stateAfterMove.winner, isNull);
    });

    test('should not allow a move if the cell is already taken', () {
      final container = ProviderContainer.test();
      const moveIndex = 0;

      container.read(gameProvider.notifier).makeMove(moveIndex);
      final stateAfterFirstMove = container.read(gameProvider);

      container.read(gameProvider.notifier).makeMove(moveIndex);
      final stateAfterSecondAttempt = container.read(gameProvider);

      expect(stateAfterSecondAttempt, equals(stateAfterFirstMove));
    });

    test('should not allow a move if the game is over', () {
      final container = ProviderContainer.test();

      final winningBoard = [
        Player.X,
        Player.X,
        Player.X,
        Player.O,
        Player.O,
        Player.none,
        Player.none,
        Player.none,
        Player.none,
      ];
      container.read(gameProvider.notifier).state = const GameState().copyWith(
        board: winningBoard,
        isGameOver: true,
        winner: Player.X,
      );
      final initialGameOverState = container.read(gameProvider);

      container.read(gameProvider.notifier).makeMove(5);
      final stateAfterMoveAttempt = container.read(gameProvider);

      expect(stateAfterMoveAttempt, equals(initialGameOverState));
    });

    test('should set winner and isGameOver when a winning move is made', () {
      final container = ProviderContainer.test();

      container.read(gameProvider.notifier).state = const GameState(
        board: [
          Player.X, Player.X, Player.none, // X needs to move at index 2
          Player.O, Player.O, Player.none,
          Player.none, Player.none, Player.none,
        ],
        currentPlayer: Player.X,
      );

      container.read(gameProvider.notifier).makeMove(2);
      final finalState = container.read(gameProvider);

      expect(finalState.isGameOver, isTrue);
      expect(finalState.winner, equals(Player.X));
    });

    test('should result in a draw if the board is full with no winner', () {
      final container = ProviderContainer.test();
      container.read(gameProvider.notifier).state = const GameState(
        board: [
          Player.X,
          Player.O,
          Player.X,
          Player.X,
          Player.O,
          Player.O,
          Player.O,
          Player.X,
          Player.none,
        ],
        currentPlayer: Player.X,
      );

      container.read(gameProvider.notifier).makeMove(8);
      final finalState = container.read(gameProvider);

      expect(finalState.isGameOver, isTrue);
      expect(
        finalState.winner,
        isNull,
        reason: "Winner should be null in a draw",
      );
    });
  });

  group('resetGame', () {
    test('should reset the game', () {
      final container = ProviderContainer.test();

      container.read(gameProvider.notifier).makeMove(0);
      expect(container.read(gameProvider).currentPlayer, Player.O);

      container.read(gameProvider.notifier).resetGame();
      final stateAfterReset = container.read(gameProvider);

      expect(stateAfterReset.board, equals(List.filled(9, Player.none)));
      expect(stateAfterReset.isGameOver, isFalse);
      expect(stateAfterReset.winner, isNull);
      expect(stateAfterReset.currentPlayer, equals(Player.X));

      container.read(gameProvider.notifier).resetGame();
      final stateAfterSecondReset = container.read(gameProvider);

      expect(stateAfterSecondReset.currentPlayer, equals(Player.X));
    });
  });
}
