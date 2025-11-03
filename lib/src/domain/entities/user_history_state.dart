import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tictactoebetclic/src/domain/entities/record_game.dart';

part 'user_history_state.freezed.dart';

@freezed
class UserHistoryState with _$UserHistoryState {
  UserHistoryState({required this.recordGameList})
    : wins = recordGameList
          .where((game) => RecordGameStatus.victory == game.status)
          .length,
      losses = recordGameList
          .where((game) => RecordGameStatus.loss == game.status)
          .length,
      draws = recordGameList
          .where((game) => RecordGameStatus.draw == game.status)
          .length;

  UserHistoryState.empty()
    : recordGameList = [],
      wins = 0,
      losses = 0,
      draws = 0;

  @override
  final List<RecordGame> recordGameList;
  @override
  final int wins;
  @override
  final int losses;
  @override
  final int draws;

  double get victoryRatio =>
      recordGameList.isEmpty ? 0 : (wins + draws / 2) / recordGameList.length;
}
