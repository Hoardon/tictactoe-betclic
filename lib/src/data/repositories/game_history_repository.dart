import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoebetclic/src/core/utils/logger.dart';
import 'package:tictactoebetclic/src/data/models/game_history.dart';
import 'package:tictactoebetclic/src/data/repositories/game_history_repository_interface.dart';
import 'package:tictactoebetclic/src/domain/entities/record_game.dart';
import 'package:tictactoebetclic/src/domain/entities/user_history_state.dart';
import 'package:tictactoebetclic/src/services/secure_storage/storage_service.dart';

part 'game_history_repository.g.dart';

@Riverpod(keepAlive: true)
IGameHistoryRepository gameHistoryRepository(Ref ref) =>
    GameHistoryRepository(ref.read(storageServiceProvider));

class GameHistoryRepository extends IGameHistoryRepository {
  GameHistoryRepository(this.service);

  final StorageService service;

  static const _gameHistoryKey = 'game_history';

  final List<GameHistory> _rawHistoryList = List.empty(growable: true);

  @override
  Future<UserHistoryState> fetchHistory() async {
    _rawHistoryList.clear();

    if (!(await service.containsKey(key: _gameHistoryKey))) {
      Log.log('No history registered on memory.');
      return UserHistoryState.empty();
    }

    final jsonString = await service.read(key: _gameHistoryKey);

    final decodedData = jsonDecode(jsonString);
    List<Map<String, Object?>> historyList = [];

    if (decodedData is List) {
      historyList = List<Map<String, Object?>>.from(decodedData);
    }

    _rawHistoryList.addAll(
      historyList.map((json) => GameHistory.fromJson(json)),
    );

    final recordGameList = _rawHistoryList
        .map(
          (game) => RecordGame(
            status: switch (game.status) {
              'Victory' => RecordGameStatus.victory,
              'Loss' => RecordGameStatus.loss,
              'Draw' => RecordGameStatus.draw,
              _ => RecordGameStatus.unknown,
            },
            opponent: switch (game.opponent) {
              'Human' => OpponentType.human,
              'AI' => OpponentType.ai,
              _ => OpponentType.unknown,
            },
            datetime: DateTime.parse(game.datetime),
          ),
        )
        .toList();

    return UserHistoryState(recordGameList: recordGameList);
  }

  @override
  Future<void> registerNewGame({required RecordGame game}) async {
    GameHistory historyGame = GameHistory(
      status: game.status.label,
      opponent: game.opponent.label,
      datetime: game.datetime.toIso8601String(),
    );
    _rawHistoryList.add(historyGame);
    await service.write(
      key: _gameHistoryKey,
      value: jsonEncode(_rawHistoryList.map((game) => game.toJson()).toList()),
    );
    Log.log('New game registered in memory.');
  }

  @override
  Future<void> clearHistory() async {
    _rawHistoryList.clear();
    await service.delete(key: _gameHistoryKey);
    Log.log('History cleared.');
  }
}
