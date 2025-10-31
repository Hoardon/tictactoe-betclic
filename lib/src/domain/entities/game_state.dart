import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tictactoebetclic/src/domain/entities/player.dart';

part 'game_state.freezed.dart';

@freezed
abstract class GameState with _$GameState {
  const factory GameState({
    @Default([
      Player.none,
      Player.none,
      Player.none,
      Player.none,
      Player.none,
      Player.none,
      Player.none,
      Player.none,
      Player.none,
    ])
    List<Player> board,
    @Default(Player.X) Player currentPlayer,
    @Default(false) bool isGameOver,
    Player? winner,
    @Default(false) bool aiActive,
    @Default(Player.O) Player aiPlayer,
  }) = _GameState;
}
