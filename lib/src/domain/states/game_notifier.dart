import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoebetclic/src/domain/ai/ai_strategy_provider.dart';
import 'package:tictactoebetclic/src/domain/entities/game_state.dart';
import 'package:tictactoebetclic/src/domain/entities/player.dart';
import 'package:tictactoebetclic/src/services/game/game_rules_provider.dart';

part 'game_notifier.g.dart';

@Riverpod(keepAlive: true)
class Game extends _$Game {
  @override
  GameState build() {
    return const GameState();
  }

  Future<void> activateAI({
    required AIStrategyEnum strategy,
    Player startPlayer = Player.X,
  }) async {
    final newAiPlayer = (startPlayer == Player.O) ? Player.X : Player.O;
    ref.read(selectedAIStrategyProvider.notifier).state = strategy;

    state = GameState(
      aiActive: true,
      aiPlayer: newAiPlayer,
    );

    _triggerAiMoveIfItsTurn();
  }

  void deactivateAI() {
    // Simply reset to a brand new, default GameState where AI is inactive.
    state = const GameState();
  }

  void makeMove(int index) {
    // Read properties directly from the state object.
    if (state.isGameOver || state.board[index] != Player.none) return;
    if (state.aiActive && state.currentPlayer == state.aiPlayer) {
      return;
    }

    _performMove(index);
    _triggerAiMoveIfItsTurn();
  }

  void resetGame() {
    // Resetting the game keeps the AI active but clears the board.
    state = GameState(
      aiActive: state.aiActive,
      aiPlayer: state.aiPlayer,
    );
    _triggerAiMoveIfItsTurn();
  }

  void _triggerAiMoveIfItsTurn() {
    // Read all properties directly from the state object.
    if (state.aiActive && !state.isGameOver && state.currentPlayer == state.aiPlayer) {
      final delay = state.board.every((cell) => cell == Player.none)
          ? const Duration(milliseconds: 100)
          : const Duration(milliseconds: 400);

      Future.delayed(delay, _makeAiMove);
    }
  }

  void _makeAiMove() {
    // Final safety check using the state object.
    if (state.isGameOver || state.currentPlayer != state.aiPlayer) return;

    final ai = ref.read(selectedAIStrategyProvider.notifier).aiStrategy;
    // Pass the state object to the AI.
    final aiMoveIndex = ai.makeMove(state);

    if (aiMoveIndex != -1) {
      _performMove(aiMoveIndex);
    }
  }

  /// Single and unified method to process any move (human or AI).
  void _performMove(int index) {
    final rules = ref.read(gameRulesProvider);
    // processMove returns a new GameState, but we need to preserve our AI flags.
    final nextState = rules.processMove(state, index);
    state = nextState.copyWith(
      aiActive: state.aiActive,
      aiPlayer: state.aiPlayer,
    );
  }
}
