import 'package:flutter_test/flutter_test.dart';
import 'package:tictactoebetclic/src/domain/ai/random_ia.dart';
import 'package:tictactoebetclic/src/domain/entities/game_state.dart';
import 'package:tictactoebetclic/src/domain/entities/player.dart';

void main() {
  group('RandomAI', () {
    // Create a single instance of the AI for all tests in this group.
    late RandomAI ai;

    setUp(() {
      ai = RandomAI();
    });

    test('should return -1 when the board is full', () {
      // ARRANGE: Create a game state with a completely full board.
      final fullBoard = [
        Player.X, Player.O, Player.X,
        Player.O, Player.X, Player.O,
        Player.X, Player.O, Player.X,
      ];
      final gameState = GameState(board: fullBoard);

      // ACT: Ask the AI to make a move.
      final move = ai.makeMove(gameState);

      // ASSERT: The AI must return -1 as no moves are possible.
      expect(move, -1, reason: 'Should return -1 when no cells are empty.');
    });

    test('should return the only available move when one cell is left', () {
      // ARRANGE: Create a board with only one empty cell at index 5.
      final almostFullBoard = [
        Player.X, Player.O, Player.X,
        Player.O, Player.X, Player.none, // The only available spot
        Player.X, Player.O, Player.O,
      ];
      final gameState = GameState(board: almostFullBoard);

      // ACT: Ask the AI to make a move.
      final move = ai.makeMove(gameState);

      // ASSERT: The AI must choose the only possible index.
      expect(move, 5, reason: 'Must select the only available cell.');
    });

    test('should return a valid move when multiple cells are available', () {
      // ARRANGE: Create a board with several empty cells.
      final board = [
        Player.X, Player.O, Player.none, // index 2
        Player.none, Player.X, Player.none, // index 3, 5
        Player.O, Player.none, Player.X, // index 7
      ];
      final gameState = GameState(board: board);
      final possibleMoves = [2, 3, 5, 7];

      // ACT: Ask the AI to make a move.
      final move = ai.makeMove(gameState);

      // ASSERT: The chosen move must be one of the available empty cells.
      expect(possibleMoves.contains(move), isTrue,
          reason: 'The move ($move) must be one of the possible options: $possibleMoves');
    });

    test('should choose a valid move on an empty board', () {
      // ARRANGE: Create a default empty game state.
      const gameState = GameState(
        board: [
          Player.none, Player.none, Player.none,
          Player.none, Player.none, Player.none,
          Player.none, Player.none, Player.none,
        ],
      );

      // ACT: Ask the AI to make a move.
      final move = ai.makeMove(gameState);

      // ASSERT: The chosen move must be a valid board index (between 0 and 8).
      expect(move, allOf(greaterThanOrEqualTo(0), lessThanOrEqualTo(8)),
          reason: 'Move must be a valid index on an empty board.');
    });
  });
}