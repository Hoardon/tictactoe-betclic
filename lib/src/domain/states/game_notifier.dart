import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoebetclic/src/domain/ai/ai_strategy_provider.dart';
import 'package:tictactoebetclic/src/domain/entities/game_state.dart';
import 'package:tictactoebetclic/src/domain/entities/player.dart';
import 'package:tictactoebetclic/src/domain/entities/record_game.dart';
import 'package:tictactoebetclic/src/domain/states/user_game_history_notifier.dart';
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
    Player forceUserPlayer = Player.X,
  }) {
    ref.read(selectedAIStrategyProvider.notifier).state = strategy;

    // Starting player is hardcoded as X. So to allow AI to start we set it as X Player.
    final newState = GameState(
      aiGame: true,
      aiPlayer: (forceUserPlayer == Player.O) ? Player.X : Player.O,
      userPlayer: forceUserPlayer,
    );
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
      aiGame: state.aiGame,
      aiPlayer: state.aiPlayer,
      userPlayer: state.userPlayer,
    );
    _updateState(newState);
  }

  /// **The single gateway for all state mutations.**
  /// It updates the state and then automatically triggers the next AI move if necessary.
  void _updateState(GameState newState) {
    if (newState == state) return;

    state = newState;
    _generateRecordGame();
    _triggerAiMoveIfItsTurn();
  }

  /// Checks all conditions to see if a move is currently allowed.
  bool _canMoveAt(int index) {
    if (state.isGameOver) return false;
    if (state.board[index] != Player.none) return false;
    if (state.aiGame && state.thisTurnPlayer == state.aiPlayer) {
      return false;
    }
    return true;
  }

  /// Processes a move for any player (human or AI) and updates the state.
  void _processMove(int index) {
    final rules = ref.read(gameRulesProvider);
    final nextCoreState = rules.processMove(state, index);
    _updateState(nextCoreState);
  }

  /// Determines if it's the AI's turn and schedules its move.
  void _triggerAiMoveIfItsTurn() {
    if (state.aiGame &&
        !state.isGameOver &&
        state.thisTurnPlayer == state.aiPlayer) {
      final delay = state.board.every((cell) => cell == Player.none)
          ? const Duration(milliseconds: 100)
          : const Duration(milliseconds: 400);

      Future.delayed(delay, _makeAiMove);
    }
  }

  /// Fetches and performs the AI's chosen move.
  void _makeAiMove() {
    if (!state.aiGame ||
        state.isGameOver ||
        state.thisTurnPlayer != state.aiPlayer) {
      return;
    }

    final ai = ref.read(selectedAIStrategyProvider.notifier).aiStrategy;
    final aiMoveIndex = ai.makeMove(state);

    if (aiMoveIndex != -1) {
      _processMove(aiMoveIndex);
    }
  }

  /// Checks if the game is over and, if so, generates a game record and
  /// adds it to the user's history.
  ///
  /// If the game is not yet finished, this function does nothing. Otherwise,
  /// it determines the final status (victory, loss, or draw) and opponent type,
  /// then calls the [UserGameHistoryNotifier] to persist the new record.
  void _generateRecordGame() {
    if (!state.isGameOver) return;

    final status = state.winner == null
        ? RecordGameStatus.draw
        : state.winner == state.userPlayer
        ? RecordGameStatus.victory
        : RecordGameStatus.loss;

    final opponent = state.aiGame ? OpponentType.ai : OpponentType.human;

    ref
        .read(userGameHistoryProvider.notifier)
        .addGameToHistory(
          RecordGame(
            status: status,
            opponent: opponent,
            datetime: DateTime.now(),
          ),
        );
  }
}
