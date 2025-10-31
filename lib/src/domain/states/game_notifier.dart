import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoebetclic/src/domain/ai/ai_strategy_provider.dart';
import 'package:tictactoebetclic/src/domain/entities/game_state.dart';
import 'package:tictactoebetclic/src/domain/entities/player.dart';

part 'game_notifier.g.dart';

@riverpod
class Game extends _$Game {
  bool _isAiActive = false;

  @override
  GameState build() {
    return const GameState();
  }

  void setAiActive(bool isActive) {
    _isAiActive = isActive;
    resetGame();
  }

  void makeMove(int index) {
    if (state.isGameOver || state.board[index] != Player.none) return;
    if (_isAiActive && state.currentPlayer == Player.O) return; // Prevent human from moving for AI

    _performMove(index);

    if (_isAiActive && !state.isGameOver && state.currentPlayer == Player.O) {
      Future.delayed(const Duration(milliseconds: 400), _triggerAiMove);
    }
  }

  /// Asks the AI strategy for a move and performs it.
  void _triggerAiMove() {
    if (state.isGameOver) return;

    final ai = ref.read(selectedAIStrategyProvider.notifier).aiStrategy;

    final aiMoveIndex = ai.makeMove(state);

    if (aiMoveIndex != -1) {
      _performMove(aiMoveIndex);
    }
  }

  /// A unified, private method to apply a move and evaluate the board.
  void _performMove(int index) {
    final updatedBoard = List<Player>.from(state.board)
      ..[index] = state.currentPlayer;

    state = state.copyWith(board: updatedBoard);
    _evaluateBoard();
  }

  /// Evaluates the board to determine if the game has ended.
  void _evaluateBoard() {
    const winningPatterns = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8], // Rows
      [0, 3, 6], [1, 4, 7], [2, 5, 8], // Columns
      [0, 4, 8], [2, 4, 6], // Diagonals
    ];

    for (final line in winningPatterns) {
      final pos1 = state.board[line[0]];
      final pos2 = state.board[line[1]];
      final pos3 = state.board[line[2]];

      if (pos1 != Player.none && pos1 == pos2 && pos1 == pos3) {
        // Winner found.
        state = state.copyWith(isGameOver: true, winner: pos1);
        return; // The game is over.
      }
    }

    if (!state.board.contains(Player.none)) {
      // It's a draw (no more moves possible).
      state = state.copyWith(isGameOver: true);
      return; // The game is over.
    }

    // Otherwise, switch player and continue.
    _togglePlayer();
  }

  void _togglePlayer() {
    final next = state.currentPlayer == Player.X ? Player.O : Player.X;
    state = state.copyWith(currentPlayer: next);
  }

  // A public method to reset the game to its initial state.
  void resetGame() {
    state = const GameState();
  }
}
