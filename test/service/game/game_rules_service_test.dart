import 'package:flutter_test/flutter_test.dart';
import 'package:tictactoebetclic/src/domain/entities/game_state.dart';
import 'package:tictactoebetclic/src/domain/entities/player.dart';
import 'package:tictactoebetclic/src/services/game/game_rules_service.dart';

void main() {
  group('GameRules Service', () {
    late IGameRules gameRules;

    setUpAll(() {
      gameRules = GameRules();
    });

    test('processMove should update board and switch player on a standard move', () {
      const initialState = GameState();
      const moveIndex = 0;

      // Ask the rules engine to process a move for Player X.
      final newState = gameRules.processMove(initialState, moveIndex);

      // The board should have Player.X at the specified index.
      expect(newState.board[moveIndex], Player.X);
      // The current player should now be Player.O.
      expect(newState.currentPlayer, Player.O);
      // The game should not be over.
      expect(newState.isGameOver, isFalse);
      // There should be no winner.
      expect(newState.winner, isNull);
    });

    test('processMove should declare Player X the winner on a winning move', () {
      final board = [
        Player.X, Player.X, Player.none,
        Player.O, Player.O, Player.none,
        Player.none, Player.none, Player.none,
      ];
      final initialState = GameState(board: board, currentPlayer: Player.X);
      const winningMoveIndex = 2;

      final newState = gameRules.processMove(initialState, winningMoveIndex);

      // The board should be updated.
      expect(newState.board[winningMoveIndex], Player.X);
      // The game should be marked as over.
      expect(newState.isGameOver, isTrue);
      // Player.X should be the winner.
      expect(newState.winner, Player.X);
    });

    test('processMove should declare Player O the winner on a winning move', () {
      final board = [
        Player.X, Player.X, Player.none,
        Player.O, Player.O, Player.none,
        Player.none, Player.none, Player.none,
      ];
      final initialState = GameState(board: board, currentPlayer: Player.O);
      const winningMoveIndex = 5;

      final newState = gameRules.processMove(initialState, winningMoveIndex);

      expect(newState.isGameOver, isTrue, reason: 'Game should be over.');
      expect(newState.winner, Player.O, reason: 'Player O should be the winner.');
    });

    test('processMove should result in a draw when the last cell is filled with no winner', () {
      final board = [
        Player.X, Player.O, Player.X,
        Player.O, Player.X, Player.X,
        Player.O, Player.none, Player.O,
      ];
      final initialState = GameState(board: board, currentPlayer: Player.X);
      const finalMoveIndex = 7;

      final newState = gameRules.processMove(initialState, finalMoveIndex);

      // The board should be full.
      expect(newState.board.contains(Player.none), isFalse);
      // The game should be over.
      expect(newState.isGameOver, isTrue, reason: 'Game should be over on a draw.');
      // There should be no winner.
      expect(newState.winner, isNull, reason: 'Winner should be null for a draw.');
    });

    test('should not switch player if the game ends', () {
      final board = [
        Player.X, Player.X, Player.none,
        Player.O, Player.O, Player.none,
        Player.none, Player.none, Player.none,
      ];
      final initialState = GameState(board: board, currentPlayer: Player.X);

      final newState = gameRules.processMove(initialState, 2);

      // Even though Player X made the move, the currentPlayer
      // property should NOT be toggled to Player O because the game is over.
      expect(newState.isGameOver, isTrue);
      expect(newState.winner, Player.X);
      expect(newState.currentPlayer, Player.X, reason: "Player should not toggle on a game-ending move.");
    });
  });
}