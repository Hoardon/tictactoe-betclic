import 'package:flutter_test/flutter_test.dart';
import 'package:tictactoebetclic/src/domain/entities/record_game.dart';

void main() {
  group('RecordGame', () {
    final testDateTime = DateTime(2024, 5, 21, 10, 30);

    test('should be instantiated correctly with given values', () {
      final record = RecordGame(
        status: RecordGameStatus.victory,
        opponent: OpponentType.ai,
        datetime: testDateTime,
      );

      expect(record.status, RecordGameStatus.victory);
      expect(record.opponent, OpponentType.ai);
      expect(record.datetime, testDateTime);
    });

    test('should support value equality', () {
      final record1 = RecordGame(
        status: RecordGameStatus.loss,
        opponent: OpponentType.human,
        datetime: testDateTime,
      );

      final record2 = RecordGame(
        status: RecordGameStatus.loss,
        opponent: OpponentType.human,
        datetime: testDateTime,
      );

      expect(record1, equals(record2));
    });

    test('should have a correct string representation', () {
      final record = RecordGame(
        status: RecordGameStatus.draw,
        opponent: OpponentType.human,
        datetime: testDateTime,
      );

      final recordString = record.toString();

      expect(recordString, contains('status: RecordGameStatus.draw'));
      expect(recordString, contains('opponent: OpponentType.human'));
      expect(recordString, contains('datetime: $testDateTime'));
    });
  });

  group('RecordGameStatusExtension', () {
    test('label should return "Victory" for RecordGameStatus.victory', () {
      expect(RecordGameStatus.victory.label, 'Victory');
    });

    test('label should return "Loss" for RecordGameStatus.loss', () {
      expect(RecordGameStatus.loss.label, 'Loss');
    });

    test('label should return "Draw" for RecordGameStatus.draw', () {
      expect(RecordGameStatus.draw.label, 'Draw');
    });

    test('label should return "Draw" for RecordGameStatus.unknown', () {
      // Verifying that the fallback case works as intended
      expect(RecordGameStatus.unknown.label, 'Draw');
    });
  });

  group('GameOpponentExtension', () {
    test('label should return "Human" for OpponentType.human', () {
      expect(OpponentType.human.label, 'Human');
    });

    test('label should return "AI" for OpponentType.ai', () {
      expect(OpponentType.ai.label, 'AI');
    });

    test('label should return "Unknown" for OpponentType.unknown', () {
      expect(OpponentType.unknown.label, 'Unknown');
    });
  });
}
