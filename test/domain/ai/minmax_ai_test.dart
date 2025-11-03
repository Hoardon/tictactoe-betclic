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

      expect(move, -1);
    });

    test('should return the only available move', () {
      // Create a board with only one empty cell at index 8.
      final almostFullBoard = [
        Player.X, Player.O, Player.X,
        Player.O, Player.X, Player.O,
        Player.X, Player.O, Player.none,
      ];
      final gameState = GameState(board: almostFullBoard);


      final move = ai.makeMove(gameState);

      expect(move, 8);
    });

    test(
        'should return one of the available moves when multiple are possible', () {
      final board = [
        Player.X, Player.O, Player.X,
        Player.O, Player.none, Player.none,
        Player.X, Player.none, Player.none,
      ];
      final gameState = GameState(board: board);
      final possibleMoves = [4, 5, 7, 8];

      final move = ai.makeMove(gameState);

      expect(possibleMoves.contains(move), isTrue,
          reason: 'The move $move should be one of the possible moves: $possibleMoves');
    });

    test('should choose a valid move on an empty board', () {
      const gameState = GameState();

      final move = ai.makeMove(gameState);

      expect(move, greaterThanOrEqualTo(0));
      expect(move, lessThanOrEqualTo(8));
    });

    group('Verify min max optimal choices', () {
      test('should choose the winning move when available', () {
        final board = [
          Player.O, Player.O, Player.none,
          Player.X, Player.X, Player.none,
          Player.none, Player.none, Player.none,
        ];
        final gameState = GameState(board: board);

        final bestMove = ai.makeMove(gameState);

        expect(bestMove, 2, reason: 'AI should choose the winning move.');
      });

      test('should block the opponent\'s winning move', () {
        final board = [
          Player.X, Player.X, Player.none, // Human is about to win here
          Player.O, Player.none, Player.none,
          Player.O, Player.none, Player.none,
        ];
        final gameState = GameState(board: board);

        final bestMove = ai.makeMove(gameState);

        expect(
            bestMove, 2, reason: 'AI must block the opponent\'s winning move.');
      });

      test('should prioritize a faster win over a later win', () {
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
        ];
        final gameState = GameState(board: board);

        final bestMove = ai.makeMove(gameState);

        expect(bestMove, 6,
            reason: 'AI should choose the move that leads to the fastest win.');
      });

      test(
          'should choose the center square as the best opening move if available', () {
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
