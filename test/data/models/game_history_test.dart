import 'package:flutter_test/flutter_test.dart';
import 'package:tictactoebetclic/src/data/models/game_history.dart';

void main() {
  group('GameHistory', () {
    const tGameHistoryModel = GameHistory(
      status: 'Victory',
      opponent: 'AI',
      datetime: '2024-05-22T10:00:00.000Z',
    );

    final tGameHistoryJson = {
      'status': 'Victory',
      'opponent': 'AI',
      'datetime': '2024-05-22T10:00:00.000Z',
    };

    test('should be a subclass of GameHistory entity', () {
      expect(tGameHistoryModel, isA<GameHistory>());
    });

    test('should be instantiated correctly', () {
      expect(tGameHistoryModel.status, 'Victory');
      expect(tGameHistoryModel.opponent, 'AI');
      expect(tGameHistoryModel.datetime, '2024-05-22T10:00:00.000Z');
    });

    test('should support value equality', () {
      const model1 = GameHistory(
        status: 'Victory',
        opponent: 'AI',
        datetime: '2024-05-22T10:00:00.000Z',
      );
      const model2 = GameHistory(
        status: 'Victory',
        opponent: 'AI',
        datetime: '2024-05-22T10:00:00.000Z',
      );

      expect(model1, equals(model2));
    });

    group('JSON Conversion', () {
      test('toJson() should return a valid JSON map', () {
        final result = tGameHistoryModel.toJson();

        expect(result, tGameHistoryJson);
      });

      test('fromJson() should return a valid GameHistory model', () {
        final result = GameHistory.fromJson(tGameHistoryJson);

        expect(result, tGameHistoryModel);
      });

      test('fromJson() should handle null or missing values gracefully if they are nullable', () {
        final jsonWithMissingField = {
          'status': 'Draw',
          'datetime': '2024-05-22T11:00:00.000Z',
        };

        expect(
              () => GameHistory.fromJson(jsonWithMissingField),
          throwsA(isA<TypeError>()),
        );
      });
    });
  });
}
