import 'package:freezed_annotation/freezed_annotation.dart';

part 'record_game.freezed.dart';

enum RecordGameStatus { victory, loss, draw, unknown }

extension RecordGameStatusExtension on RecordGameStatus {
  String get label {
    switch (this) {
      case RecordGameStatus.victory:
        return 'Victory';
      case RecordGameStatus.loss:
        return 'Loss';
      case RecordGameStatus.draw:
      case RecordGameStatus.unknown:
        return 'Draw';
    }
  }
}

enum OpponentType { human, ai, unknown }

extension GameOpponentExtension on OpponentType {
  String get label {
    switch (this) {
      case OpponentType.human:
        return 'Human';
      case OpponentType.ai:
        return 'AI';
      case OpponentType.unknown:
        return 'Unknown';
    }
  }
}

@freezed
abstract class RecordGame with _$RecordGame {
  const factory RecordGame({
    required RecordGameStatus status,
    required OpponentType opponent,
    required DateTime datetime,
  }) = _RecordGame;
}
