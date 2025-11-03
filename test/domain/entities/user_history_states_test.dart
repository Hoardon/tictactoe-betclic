import 'package:flutter_test/flutter_test.dart';
import 'package:tictactoebetclic/src/domain/entities/record_game.dart';
import 'package:tictactoebetclic/src/domain/entities/user_history_state.dart';

void main() {
  group('UserHistoryState', () {
    RecordGame createRecord(
      RecordGameStatus status, [
      OpponentType? opponent,
      DateTime? datetime,
    ]) {
      return RecordGame(
        status: status,
        opponent: opponent ?? OpponentType.ai,
        datetime: datetime ?? DateTime.now(),
      );
    }

    group('Main Constructor Logic', () {
      test(
        'should correctly count wins, losses, and draws from a mixed record list',
        () {
          final recordList = [
            createRecord(RecordGameStatus.victory),
            createRecord(RecordGameStatus.victory),
            createRecord(RecordGameStatus.victory),
            createRecord(RecordGameStatus.loss),
            createRecord(RecordGameStatus.loss),
            createRecord(RecordGameStatus.draw),
          ];

          final state = UserHistoryState(recordGameList: recordList);

          expect(state.wins, 3);
          expect(state.losses, 2);
          expect(state.draws, 1);
          expect(state.recordGameList.length, 6);
        },
      );

      test('should handle a list with only one type of result', () {
        final recordList = [
          createRecord(RecordGameStatus.victory),
          createRecord(RecordGameStatus.victory),
        ];

        final state = UserHistoryState(recordGameList: recordList);

        expect(state.wins, 2);
        expect(state.losses, 0);
        expect(state.draws, 0);
      });
    });

    group('victoryRatio Getter Logic', () {
      test('should calculate the correct ratio for a mix of results', () {
        final recordList = List<RecordGame>.from([
          ...List.filled(10, createRecord(RecordGameStatus.victory)),
          ...List.filled(6, createRecord(RecordGameStatus.loss)),
          ...List.filled(4, createRecord(RecordGameStatus.draw)),
        ]);

        final state = UserHistoryState(recordGameList: recordList);

        // Expected ratio = (10 wins + (4 draws / 2)) / 20 total games
        //              = (10 + 2) / 20 = 12 / 20 = 0.6
        final ratio = state.victoryRatio;
        expect(ratio, 0.6);
      });

      test('should return 1.0 when all games are victories', () {
        final recordList = [
          createRecord(RecordGameStatus.victory),
          createRecord(RecordGameStatus.victory),
        ];
        final state = UserHistoryState(recordGameList: recordList);

        expect(state.victoryRatio, 1.0);
      });

      test('should return 0.0 when the record list is empty', () {
        final state = UserHistoryState(recordGameList: []);

        final ratio = state.victoryRatio;

        expect(ratio, 0.0);
      });
    });

    group('Empty Constructor', () {
      test('should create a state with zero values and an empty list', () {
        final state = UserHistoryState.empty();

        expect(state.recordGameList, isEmpty);
        expect(state.wins, 0);
        expect(state.losses, 0);
        expect(state.draws, 0);
      });

      test('victoryRatio for an empty state should be 0.0', () {
        final state = UserHistoryState.empty();

        expect(state.victoryRatio, 0.0);
      });
    });

    test('should support value equality', () {
      OpponentType opponentType = OpponentType.human;
      DateTime now = DateTime.now();
      final recordList1 = [
        createRecord(RecordGameStatus.victory, opponentType, now),
      ];
      final recordList2 = [
        createRecord(RecordGameStatus.victory, opponentType, now),
      ];

      final state1 = UserHistoryState(recordGameList: recordList1);
      final state2 = UserHistoryState(recordGameList: recordList2);

      expect(state1, equals(state2));
    });
  });
}
