import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ai_game_state.g.dart';

@riverpod
class AIGameState extends _$AIGameState {
  @override
  bool build() => false;

  @override
  set state(bool value) => super.state = value;
}