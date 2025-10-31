import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoebetclic/src/domain/ai/ai_strategy_provider.dart';
import 'package:tictactoebetclic/src/domain/entities/game_state.dart';
import 'package:tictactoebetclic/src/domain/entities/player.dart';
import 'package:tictactoebetclic/src/services/game/game_rules_provider.dart';

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

  /// Single and unified method to process any move (human or AI).
  void _performMove(int index) {
    final rules = ref.read(gameRulesProvider);
    state = rules.processMove(state, index);
  }

  /// A public method to reset the game to its initial state.
  void resetGame() {
    state = const GameState();
  }
}
