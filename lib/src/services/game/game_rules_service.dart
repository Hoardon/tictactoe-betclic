import 'package:flutter/foundation.dart';
import 'package:tictactoebetclic/src/domain/entities/game_state.dart';
import 'package:tictactoebetclic/src/domain/entities/player.dart';

abstract class IGameRules {
  GameState processMove(GameState currentState, int index);
}

/// A pure, testable class that contains the core business logic of the game.
/// It does not hold state; it only calculates new states based on inputs.
@immutable
class GameRules extends IGameRules {
  /// Processes a move and returns the new state of the game.
  @override
  GameState processMove(GameState currentState, int index) {
    // 1. Apply the move to the board
    final updatedBoard = List<Player>.from(currentState.board)
      ..[index] = currentState.currentPlayer;

    // 2. Evaluate the outcome of the move
    final outcome = _evaluateOutcome(updatedBoard);

    // If there's a winner or a draw, the game is over.
    if (outcome.isGameOver) {
      return currentState.copyWith(
        board: updatedBoard,
        isGameOver: true,
        winner: outcome.winner,
      );
    }

    // 3. If the game is not over, switch to the next player.
    final nextPlayer = _togglePlayer(currentState.currentPlayer);
    return currentState.copyWith(
      board: updatedBoard,
      currentPlayer: nextPlayer,
    );
  }

  /// Switches the current player.
  Player _togglePlayer(Player currentPlayer) {
    return currentPlayer == Player.X ? Player.O : Player.X;
  }

  /// Evaluates the board to determine the game's outcome.
  ({bool isGameOver, Player? winner}) _evaluateOutcome(List<Player> board) {
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
        // Winner found.
        return (isGameOver: true, winner: pos1);
      }
    }

    if (!board.contains(Player.none)) {
      // It's a draw (no winner, but the game is over).
      return (isGameOver: true, winner: null);
    }

    // The game is still ongoing.
    return (isGameOver: false, winner: null);
  }
}
