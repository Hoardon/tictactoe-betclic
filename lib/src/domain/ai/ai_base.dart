import 'package:tictactoebetclic/src/domain/entities/game_state.dart';

/// Abstract contract for any AI player strategy.
///
/// This allows us to create different AI difficulties (e.g., easy, medium, hard)
/// that can be swapped without changing the core game logic.
abstract class AIBase {
  /// Determines the best move for the AI given the current game state.
  ///
  /// Returns the integer index of the cell the AI has chosen.
  int makeMove(GameState gameState);
}