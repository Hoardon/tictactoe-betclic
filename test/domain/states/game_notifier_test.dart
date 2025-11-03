import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tictactoebetclic/src/domain/ai/ai_strategy_provider.dart';
import 'package:tictactoebetclic/src/domain/entities/game_state.dart';
import 'package:tictactoebetclic/src/domain/entities/player.dart';
import 'package:tictactoebetclic/src/domain/entities/record_game.dart';
import 'package:tictactoebetclic/src/domain/states/game_notifier.dart';
import 'package:tictactoebetclic/src/domain/states/user_game_history_notifier.dart';
import 'package:tictactoebetclic/src/services/game/game_rules_provider.dart';
import 'package:tictactoebetclic/src/services/game/game_rules_service.dart';

class MockGameRules extends Mock implements GameRules {}

class MockUserGameHistoryNotifier extends Mock
    implements UserGameHistoryNotifier {}

void main() {
  late MockGameRules mockGameRules;
  late MockUserGameHistoryNotifier mockHistoryNotifier;
  late ProviderContainer container;

  setUp(() {
    mockGameRules = MockGameRules();
    mockHistoryNotifier = MockUserGameHistoryNotifier();

    container = ProviderContainer(
      overrides: [gameRulesProvider.overrideWithValue(mockGameRules),
      userGameHistoryProvider.overrideWith(() => mockHistoryNotifier),],
    );

    registerFallbackValue(const GameState());
    registerFallbackValue(
      RecordGame(
        status: RecordGameStatus.draw,
        opponent: OpponentType.ai,
        datetime: DateTime.now(),
      ),
    );
  });

  group('Initial State & AI Activation', () {
    test('should have a correct initial state', () {
      final initialState = container.read(gameProvider);
      expect(initialState, const GameState());
    });

    test('activateAI should update state with correct AI and user players', () async { // 1. Rendre async
      final initialAIState = const GameState(aiGame: true, aiPlayer: Player.X, userPlayer: Player.O);
      when(() => mockGameRules.processMove(any(), any())).thenReturn(initialAIState);

      container.read(gameProvider.notifier).activateAI(
        strategy: AIStrategyEnum.easy,
        forceUserPlayer: Player.O,
      );

      final state = container.read(gameProvider);
      expect(state.aiGame, isTrue);
      expect(state.userPlayer, Player.O);
      expect(state.aiPlayer, Player.X);
    });

    test('deactivateAI should reset the state to default', () {
      container
          .read(gameProvider.notifier)
          .activateAI(strategy: AIStrategyEnum.easy);
      expect(container.read(gameProvider).aiGame, isTrue);

      container.read(gameProvider.notifier).deactivateAI();

      expect(container.read(gameProvider), const GameState());
    });
  });

  group('makeMove (Human)', () {
    test('should process a valid move and update state via GameRules', () {
      const moveIndex = 0;
      final initialState = container.read(gameProvider);
      final stateAfterMove = initialState.copyWith(
        board: List.filled(9, Player.none)..[moveIndex] = Player.X,
        thisTurnPlayer: Player.O,
      );
      when(
        () => mockGameRules.processMove(any(), any()),
      ).thenReturn(stateAfterMove);

      container.read(gameProvider.notifier).makeMove(moveIndex);

      verify(
        () => mockGameRules.processMove(initialState, moveIndex),
      ).called(1);
      expect(container.read(gameProvider), stateAfterMove);
    });

    test('should NOT allow a move if cell is already taken', () {
      final initialState = container.read(gameProvider);
      container.read(gameProvider.notifier).state = initialState.copyWith(
        board: List.filled(9, Player.none)..[0] = Player.X,
      );

      container.read(gameProvider.notifier).makeMove(0);

      verifyNever(() => mockGameRules.processMove(any(), any()));
    });
  });

  group('resetGame', () {
    test('should reset the board but keep AI settings', () {
      container
          .read(gameProvider.notifier)
          .activateAI(strategy: AIStrategyEnum.easy, forceUserPlayer: Player.O);
      when(() => mockGameRules.processMove(any(), any())).thenReturn(
        const GameState(
          aiGame: true,
          userPlayer: Player.O,
          aiPlayer: Player.X,
        ),
      );
      container.read(gameProvider.notifier).makeMove(0);

      container.read(gameProvider.notifier).resetGame();
      final stateAfterReset = container.read(gameProvider);

      expect(stateAfterReset.board, equals(List.filled(9, Player.none)));
      expect(stateAfterReset.isGameOver, isFalse);
      expect(stateAfterReset.winner, isNull);
      expect(stateAfterReset.thisTurnPlayer, equals(Player.X));
      expect(stateAfterReset.aiGame, isTrue);
      expect(stateAfterReset.userPlayer, Player.O);
      expect(stateAfterReset.aiPlayer, Player.X);
    });
  });
}
