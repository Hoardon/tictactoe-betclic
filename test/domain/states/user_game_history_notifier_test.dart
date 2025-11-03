import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tictactoebetclic/src/data/repositories/game_history_repository.dart';
import 'package:tictactoebetclic/src/domain/entities/record_game.dart';
import 'package:tictactoebetclic/src/domain/entities/user_history_state.dart';
import 'package:tictactoebetclic/src/domain/states/user_game_history_notifier.dart';

class MockGameHistoryRepository extends Mock implements GameHistoryRepository {}

void main() {
  RecordGame createDummyRecord(RecordGameStatus status) {
    return RecordGame(
      status: status,
      opponent: OpponentType.ai,
      datetime: DateTime.now(),
    );
  }

  group('UserGameHistoryNotifier', () {
    late MockGameHistoryRepository mockRepository;
    late ProviderContainer container;

    setUp(() {
      mockRepository = MockGameHistoryRepository();

      container = ProviderContainer(
        overrides: [
          gameHistoryRepositoryProvider.overrideWithValue(mockRepository),
        ],
      );

      registerFallbackValue(createDummyRecord(RecordGameStatus.unknown));
    });

    tearDown(() {
      container.dispose();
    });

    test('initial state is UserHistoryState.empty()', () {
      when(() => mockRepository.fetchHistory())
          .thenAnswer((_) async => UserHistoryState.empty());

      final notifier = container.read(userGameHistoryProvider.notifier);

      expect(notifier.state, UserHistoryState.empty());
    });

    test('fetch() should update state with data from repository', () async {
      final testHistoryState = UserHistoryState(recordGameList: [
        createDummyRecord(RecordGameStatus.victory),
      ]);
      when(() => mockRepository.fetchHistory())
          .thenAnswer((_) async => testHistoryState);

      final notifier = container.read(userGameHistoryProvider.notifier);
      await notifier.fetch(); // Await the future

      expect(notifier.state, testHistoryState);
      expect(notifier.state.wins, 1);
    });

    test('addGameToHistory() should add a game and update state', () {
      when(() => mockRepository.fetchHistory())
          .thenAnswer((_) async => UserHistoryState.empty());
      final notifier = container.read(userGameHistoryProvider.notifier);
      expect(notifier.state.recordGameList, isEmpty);

      final newGame = createDummyRecord(RecordGameStatus.victory);
      notifier.addGameToHistory(newGame);

      verify(() => mockRepository.registerNewGame(game: newGame)).called(1);

      expect(notifier.state.recordGameList.length, 1);
      expect(notifier.state.recordGameList.first, newGame);
      expect(notifier.state.wins, 1);

      final newGame2 = createDummyRecord(RecordGameStatus.loss);
      notifier.addGameToHistory(newGame2);
      notifier.addGameToHistory(newGame2);

      verify(() => mockRepository.registerNewGame(game: newGame2)).called(2);

      expect(notifier.state.recordGameList.length, 3);
      expect(notifier.state.recordGameList.last, newGame2);
      expect(notifier.state.losses, 2);
    });

    test('clearHistory() should call repository and reset state to empty', () async {
      final initialState = UserHistoryState(recordGameList: [
        createDummyRecord(RecordGameStatus.victory),
      ]);
      when(() => mockRepository.fetchHistory())
          .thenAnswer((_) async => initialState);
      final notifier = container.read(userGameHistoryProvider.notifier);
      await notifier.fetch();
      expect(notifier.state, initialState); // Pre-condition check

      when(() => mockRepository.clearHistory()).thenAnswer((_) async {});

      notifier.clearHistory();

      verify(() => mockRepository.clearHistory()).called(1);

      expect(notifier.state, UserHistoryState.empty());
    });
  });
}
