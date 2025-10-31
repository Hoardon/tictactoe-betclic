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

  void activateAI({
    required AIStrategyEnum strategy,
    Player startPlayer = Player.X,
  }) {
    final newAiPlayer = (startPlayer == Player.O) ? Player.X : Player.O;
    ref.read(selectedAIStrategyProvider.notifier).state = strategy;

    final newState = GameState(aiActive: true, aiPlayer: newAiPlayer);
    _updateState(newState);
  }

  void deactivateAI() {
    _updateState(const GameState());
  }

  void makeMove(int index) {
    if (!_canMoveAt(index)) return;
    _processMove(index);
  }

  void resetGame() {
    // This command's intent is to create a new game board, preserving the current AI settings.
    final newState = GameState(
      aiActive: state.aiActive,
      aiPlayer: state.aiPlayer,
    );
    _updateState(newState);
  }


  /// **The single gateway for all state mutations.**
  /// It updates the state and then automatically triggers the next AI move if necessary.
  void _updateState(GameState newState) {
    if (newState == state) return;

    state = newState;
    _triggerAiMoveIfItsTurn();
  }

  /// Checks all conditions to see if a move is currently allowed.
  bool _canMoveAt(int index) {
    if (state.isGameOver) return false;
    if (state.board[index] != Player.none) return false;
    if (state.aiActive && state.currentPlayer == state.aiPlayer) {
      return false;
    }
    return true;
  }

  /// Processes a move for any player (human or AI) and updates the state.
  void _processMove(int index) {
    final rules = ref.read(gameRulesProvider);
    final nextCoreState = rules.processMove(state, index);

    final fullNextState = nextCoreState;
    _updateState(fullNextState);
  }

  /// Determines if it's the AI's turn and schedules its move.
  void _triggerAiMoveIfItsTurn() {
    if (state.aiActive && !state.isGameOver && state.currentPlayer == state.aiPlayer) {
      final delay = state.board.every((cell) => cell == Player.none)
          ? const Duration(milliseconds: 100)
          : const Duration(milliseconds: 400);

      Future.delayed(delay, _makeAiMove);
    }
  }

  /// Fetches and performs the AI's chosen move.
  void _makeAiMove() {
    if (!state.aiActive || state.isGameOver || state.currentPlayer != state.aiPlayer) return;

    final ai = ref.read(selectedAIStrategyProvider.notifier).aiStrategy;
    final aiMoveIndex = ai.makeMove(state);

    if (aiMoveIndex != -1) {
      _processMove(aiMoveIndex);
    }
  }
}