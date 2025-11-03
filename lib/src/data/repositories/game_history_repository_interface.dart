import 'package:tictactoebetclic/src/domain/entities/record_game.dart';
import 'package:tictactoebetclic/src/domain/entities/user_history_state.dart';

abstract class IGameHistoryRepository {
  IGameHistoryRepository();

  Future<UserHistoryState> fetchHistory();

  Future<void> registerNewGame({required RecordGame game});

  Future<void> clearHistory();
}