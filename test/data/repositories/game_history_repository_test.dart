import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tictactoebetclic/src/data/models/game_history.dart';
import 'package:tictactoebetclic/src/data/repositories/game_history_repository.dart';
import 'package:tictactoebetclic/src/domain/entities/record_game.dart';
import 'package:tictactoebetclic/src/domain/entities/user_history_state.dart';
import 'package:tictactoebetclic/src/services/secure_storage/storage_service.dart';

class MockStorageService extends Mock implements StorageService {}

void main() {
  late GameHistoryRepository repository;
  late MockStorageService mockStorageService;
  const gameHistoryKey = 'game_history';
  final DateTime tDate = DateTime(2025, 1, 1, 10, 0, 0);

  setUp(() {
    mockStorageService = MockStorageService();
    repository = GameHistoryRepository(mockStorageService);

    registerFallbackValue(RecordGame(
        status: RecordGameStatus.unknown,
        opponent: OpponentType.unknown,
        datetime: tDate));
  });


  group('fetchHistory', () {
    test('should return UserHistoryState.empty when storage key does not exist', () async {
      when(() => mockStorageService.containsKey(key: gameHistoryKey))
          .thenAnswer((_) async => false);

      final result = await repository.fetchHistory();

      expect(result, UserHistoryState.empty());
      verifyNever(() => mockStorageService.read(key: any(named: 'key')));
    });

    test('should return a populated UserHistoryState from valid JSON in storage', () async {
      final historyData = [
        GameHistory(
          status: 'Victory',
          opponent: 'AI',
          datetime: tDate.toIso8601String(),
        ).toJson(),
        GameHistory(
          status: 'Draw',
          opponent: 'Human',
          datetime: tDate.add(const Duration(days: 1)).toIso8601String(),
        ).toJson(),
      ];
      final jsonString = jsonEncode(historyData);

      when(() => mockStorageService.containsKey(key: gameHistoryKey)).thenAnswer((_) async => true);
      when(() => mockStorageService.read(key: gameHistoryKey)).thenAnswer((_) async => jsonString);

      final result = await repository.fetchHistory();

      expect(result.recordGameList.length, 2);
      expect(result.wins, 1);
      expect(result.draws, 1);
      expect(result.losses, 0);
      expect(result.recordGameList.first.status, RecordGameStatus.victory);
      expect(result.recordGameList.last.opponent, OpponentType.human);
    });
  });

  group('registerNewGame', () {
    test('should encode the game and write the full history to storage', () async {
      final newGame = RecordGame(status: RecordGameStatus.loss, opponent: OpponentType.ai, datetime: tDate);

      when(() => mockStorageService.write(key: gameHistoryKey, value: any(named: 'value')))
          .thenAnswer((_) async {});

      await repository.registerNewGame(game: newGame);

      final captured = verify(() => mockStorageService.write(key: gameHistoryKey, value: captureAny(named: 'value'))).captured;

      final writtenValue = captured.first as String;
      final decodedList = jsonDecode(writtenValue) as List;

      expect(decodedList.length, 1);
      expect(decodedList.first['status'], 'Loss');
      expect(decodedList.first['opponent'], 'AI');
      expect(decodedList.first['datetime'], tDate.toIso8601String());
    });
  });

  group('clearHistory', () {
    test('should call the delete method on the storage service', () async {
      when(() => mockStorageService.delete(key: gameHistoryKey)).thenAnswer((_) async {});

      await repository.clearHistory();

      verify(() => mockStorageService.delete(key: gameHistoryKey)).called(1);
    });
  });
}