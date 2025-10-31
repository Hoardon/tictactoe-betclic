import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoebetclic/src/services/game/game_rules_service.dart';

part 'game_rules_provider.g.dart';

@riverpod
IGameRules gameRules(Ref ref) {
  return GameRules();
}