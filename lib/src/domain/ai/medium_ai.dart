import 'dart:math';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tictactoebetclic/src/domain/ai/ai_base.dart';
import 'package:tictactoebetclic/src/domain/entities/game_state.dart';
import 'package:tictactoebetclic/src/domain/entities/player.dart';

final mediumAIProvider = Provider((ref) => MediumAI());

/// A "medium" difficulty AI that follows a clear set of priorities:
/// 1. Win if an immediate winning move is available.
/// 2. Block the opponent if they are about to win.
/// 3. Otherwise, choose a random available cell.
class MediumAI implements AIBase {
  @override
  int makeMove(GameState gameState) {
    final board = gameState.board;
    // In our setup, the AI is always Player.O
    const aiPlayer = Player.O;
    const humanPlayer = Player.X;

    // Priority 1: Check if the AI can win in this turn.
    final winningMove = _findWinningMove(board, aiPlayer);
    if (winningMove != -1) {
      return winningMove;
    }

    // Priority 2: Check if the human is about to win and block them.
    final blockingMove = _findWinningMove(board, humanPlayer);
    if (blockingMove != -1) {
      return blockingMove;
    }

    // Priority 3: If no immediate win or block, make a random move.
    return _makeRandomMove(board);
  }

  /// Finds an index where the given player can win on the next move.
  /// Returns -1 if no such move exists.
  int _findWinningMove(List<Player> board, Player player) {
    for (int i = 0; i < board.length; i++) {
      if (board[i] == Player.none) {
        // Create a temporary board to test a hypothetical move.
        final testBoard = List<Player>.from(board);
        testBoard[i] = player;

        // If this move results in a win, return the index.
        if (_isWinner(testBoard, player)) {
          return i;
        }
      }
    }
    return -1; // No winning move found
  }

  /// Makes a move on a random available cell.
  int _makeRandomMove(List<Player> board) {
    final availableMoves = <int>[];
    for (int i = 0; i < board.length; i++) {
      if (board[i] == Player.none) {
        availableMoves.add(i);
      }
    }

    if (availableMoves.isEmpty) {
      return -1; // Should not happen in a normal game flow
    }

    return availableMoves[Random().nextInt(availableMoves.length)];
  }

  /// Checks if the specified player has won on the given board.
  bool _isWinner(List<Player> board, Player player) {
    // This logic is similar to your _evaluateBoard method.
    const winningPatterns = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8], // Rows
      [0, 3, 6], [1, 4, 7], [2, 5, 8], // Columns
      [0, 4, 8], [2, 4, 6], // Diagonals
    ];

    for (final line in winningPatterns) {
      final pos1 = board[line[0]];
      final pos2 = board[line[1]];
      final pos3 = board[line[2]];

      if (pos1 == player && pos2 == player && pos3 == player) {
        return true;
      }
    }
    return false;
  }
}
