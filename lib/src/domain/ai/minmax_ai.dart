import 'dart:math';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tictactoebetclic/src/domain/entities/game_state.dart';
import 'package:tictactoebetclic/src/domain/entities/player.dart';
import 'package:tictactoebetclic/src/domain/ai/ai_base.dart';

final minMaxAIProvider = Provider((ref) => MinMaxAI());

/// An "easy" AI that chooses a random available cell.
class MinMaxAI implements AIBase {
  @override
  int makeMove(GameState gameState) {
    int bestScore = -1000;
    int bestMove = -1;

    // The AI is always Player.O in our current setup
    final aiPlayer = Player.O;
    final humanPlayer = Player.X;

    for (int i = 0; i < gameState.board.length; i++) {
      if (gameState.board[i] == Player.none) {
        // Create a new board state by making a hypothetical move
        final newBoard = List<Player>.from(gameState.board);
        newBoard[i] = aiPlayer;

        // Call the minimax function on this new board to get its score
        int moveScore = _minimax(
          board: newBoard,
          depth: 0,
          isMaximizing: false,
          aiPlayer: aiPlayer,
          humanPlayer: humanPlayer,
        );

        if (moveScore > bestScore) {
          bestScore = moveScore;
          bestMove = i;
        }
      }
    }
    return bestMove;
  }

  /// The recursive minimax function
  ///
  /// [board] - The current board state we are evaluating.
  /// [depth] - How many moves deep we are in the recursion.
  /// [isMaximizing] - Are we currently trying to maximize the score (AI's turn)
  ///                  or minimize it (Human's turn)?
  int _minimax({
    required List<Player> board,
    required int depth,
    required bool isMaximizing,
    required Player aiPlayer,
    required Player humanPlayer,
  }) {
    int score = _evaluateScore(
      board: board,
      depth: depth,
      aiPlayer: aiPlayer,
      humanPlayer: humanPlayer,
    );

    // If a winner is found, return the score immediately.
    if (score == 10 - depth || score == -10 + depth) {
      return score;
    }

    // If there are no more empty cells, it's a draw. Return a neutral score.
    if (!board.contains(Player.none)) {
      return 0; // A draw has a score of 0.
    }

    if (isMaximizing) {
      // AI's turn (Maximizing Player)
      int bestScore = -1000;
      for (int i = 0; i < board.length; i++) {
        if (board[i] == Player.none) {
          board[i] = aiPlayer; // Make a hypothetical move
          bestScore = max(
            bestScore,
            _minimax(
              board: board,
              depth: depth + 1,
              isMaximizing: false,
              aiPlayer: aiPlayer,
              humanPlayer: humanPlayer,
            ),
          );
          board[i] = Player.none; // Undo the move
        }
      }
      return bestScore;
    } else {
      // Human's turn (Minimizing Player)
      int bestScore = 1000;
      for (int i = 0; i < board.length; i++) {
        if (board[i] == Player.none) {
          board[i] = humanPlayer; // Make a hypothetical move
          bestScore = min(
            bestScore,
            _minimax(
              board: board,
              depth: depth + 1,
              isMaximizing: true,
              aiPlayer: aiPlayer,
              humanPlayer: humanPlayer,
            ),
          );
          board[i] = Player.none; // Undo the move
        }
      }
      return bestScore;
    }
  }

  /// Evaluates the board and returns a score.
  /// Returns:
  ///   +10 - depth if the AI wins.
  ///   -10 + depth if the Human wins.
  ///    0 if the game is ongoing or a draw.
  int _evaluateScore({
    required List<Player> board,
    required int depth,
    required Player aiPlayer,
    required Player humanPlayer,
  }) {
    const winningPatterns = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8], // Rows
      [0, 3, 6], [1, 4, 7], [2, 5, 8], // Columns
      [0, 4, 8], [2, 4, 6], // Diagonals
    ];

    for (final line in winningPatterns) {
      final pos1 = board[line[0]];
      final pos2 = board[line[1]];
      final pos3 = board[line[2]];

      if (pos1 != Player.none && pos1 == pos2 && pos1 == pos3) {
        if (pos1 == aiPlayer) {
          // AI wins. We subtract depth to prioritize faster wins.
          return 10 - depth;
        } else {
          // Human wins. We add depth to prioritize blocking moves that lead to faster losses.
          return -10 + depth;
        }
      }
    }

    return 0;
  }
}
