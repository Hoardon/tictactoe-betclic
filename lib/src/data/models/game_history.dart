import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_history.freezed.dart';
part 'game_history.g.dart';

@freezed
@JsonSerializable()
class GameHistory with _$GameHistory {
  const GameHistory({
    required this.status,
    required this.opponent,
    required this.datetime,
  });

  @override
  final String status;
  @override
  final String opponent;
  @override
  final String datetime;

  factory GameHistory.fromJson(Map<String, Object?> json) =>
      _$GameHistoryFromJson(json);

  Map<String, Object?> toJson() => _$GameHistoryToJson(this);
}