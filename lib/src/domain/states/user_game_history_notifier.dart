import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoebetclic/src/data/repositories/game_history_repository.dart';
import 'package:tictactoebetclic/src/domain/entities/record_game.dart';
import 'package:tictactoebetclic/src/domain/entities/user_history_state.dart';

part 'user_game_history_notifier.g.dart';

@Riverpod(keepAlive: true)
class UserGameHistoryNotifier extends _$UserGameHistoryNotifier {

  @override
  UserHistoryState build() {
    fetch();
    return UserHistoryState.empty();
  }

  Future<void> fetch() async {
    state = await ref.read(gameHistoryRepositoryProvider).fetchHistory();
  }

  void addGameToHistory(RecordGame game) {
    ref.read(gameHistoryRepositoryProvider).registerNewGame(game: game);
    state = state.copyWith(recordGameList: List<RecordGame>.of([...state.recordGameList, game]));
  }

  void clearHistory() {
    ref.read(gameHistoryRepositoryProvider).clearHistory();
    state = UserHistoryState.empty();
  }
}
