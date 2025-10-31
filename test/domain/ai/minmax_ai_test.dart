import 'package:flutter_test/flutter_test.dart';
import 'package:tictactoebetclic/src/domain/ai/minmax_ai.dart';
import 'package:tictactoebetclic/src/domain/entities/game_state.dart';
import 'package:tictactoebetclic/src/domain/entities/player.dart';

void main() {
  group('MinMaxAI', () {
    late MinMaxAI ai;

    setUp(() {
      ai = MinMaxAI();
    });

    test('should return -1 when the board is full', () {
      final fullBoard = const [
        Player.X, Player.O, Player.X,
        Player.O, Player.X, Player.O,
        Player.X, Player.O, Player.X,
      ];
      final gameState = GameState(board: fullBoard);

      final move = ai.makeMove(gameState);

      // The AI should return -1, indicating no move is possible.
      expect(move, -1);
    });

    test('should return the only available move', () {
      // Create a board with only one empty cell at index 8.
      final almostFullBoard = [
        Player.X, Player.O, Player.X,
        Player.O, Player.X, Player.O,
        Player.X, Player.O, Player.none, // The only available spot
      ];
      final gameState = GameState(board: almostFullBoard);


      final move = ai.makeMove(gameState);

      // The AI must choose the only possible index.
      expect(move, 8);
    });

    test(
        'should return one of the available moves when multiple are possible', () {
      // Create a board with several empty cells.
      final board = [
        Player.X, Player.O, Player.X,
        Player.O, Player.none, Player.none, // Available moves are 4, 5
        Player.X, Player.none, Player.none, // Available moves are 7, 8
      ];
      final gameState = GameState(board: board);
      final possibleMoves = [4, 5, 7, 8];

      final move = ai.makeMove(gameState);

      // The chosen move must be one of the available options.
      expect(possibleMoves.contains(move), isTrue,
          reason: 'The move $move should be one of the possible moves: $possibleMoves');
    });

    test('should choose a valid move on an empty board', () {
      // ARRANGE: Create a default empty game state.
      const gameState = GameState();

      // ACT: Ask the AI to make a move.
      final move = ai.makeMove(gameState);

      // ASSERT: The chosen move must be a valid board index (0-8).
      expect(move, greaterThanOrEqualTo(0));
      expect(move, lessThanOrEqualTo(8));
    });

    group('Verify min max optimal choices', () {
      test('should choose the winning move when available', () {
        // ARRANGE: A board where AI (Player O) can win by placing a piece at index 6.
        // O, O, _
        // X, X, _
        // _, _, _
        final board = [
          Player.O, Player.O, Player.none,
          Player.X, Player.X, Player.none,
          Player.none, Player.none, Player.none,
        ];
        final gameState = GameState(board: board);

        // ACT: Ask the AI for the best move.
        final bestMove = ai.makeMove(gameState);

        // ASSERT: The AI must choose index 2 to complete the top row and win.
        expect(bestMove, 2, reason: 'AI should choose the winning move.');
      });

      test('should block the opponent\'s winning move', () {
        // ARRANGE: A board where the Human (Player X) can win on the next turn at index 2.
        // X, X, _  <-- AI must block here
        // O, _, _
        // O, _, _
        final board = [
          Player.X, Player.X, Player.none, // Human is about to win here
          Player.O, Player.none, Player.none,
          Player.O, Player.none, Player.none,
        ];
        final gameState = GameState(board: board);

        // ACT: Ask the AI for the best move.
        final bestMove = ai.makeMove(gameState);

        // ASSERT: The AI's only logical move is to block the opponent at index 2.
        expect(
            bestMove, 2, reason: 'AI must block the opponent\'s winning move.');
      });

      test('should prioritize a faster win over a later win', () {
        // ARRANGE: A complex board state where the AI (Player O) has two paths to victory.
        // Path 1 (Faster Win): Placing at index 6 creates an immediate win [0, 3, 6].
        // Path 2 (Slower Win): Placing at index 8 creates a "fork", guaranteeing a win on a later turn.
        // O, X, O
        // O, X, X
        // _, _, _
        final board = [
          Player.O,
          Player.X,
          Player.O,
          Player.O,
          Player.X,
          Player.X,
          Player.none,
          Player.none,
          Player.none,
          // AI is Player O, it's their turn
        ];
        final gameState = GameState(board: board);

        final bestMove = ai.makeMove(gameState);

        // The AI must choose index 6 for the immediate victory,
        // because the algorithm is designed to prefer wins with a lower depth.
        expect(bestMove, 6,
            reason: 'AI should choose the move that leads to the fastest win.');
      });

      test(
          'should choose the center square as the best opening move if available', () {
        // A board where Human (X) has made a move in the corner.
        // X, _, _
        // _, _, _
        // _, _, _
        final board = [
          Player.X, Player.none, Player.none,
          Player.none, Player.none, Player.none,
          Player.none, Player.none, Player.none,
        ];
        final gameState = GameState(board: board);

        final bestMove = ai.makeMove(gameState);

        expect(bestMove, 4,
            reason: 'The AI should identify the center as the strongest counter-move.');
      });
    });
  });
}
