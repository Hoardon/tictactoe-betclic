import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoebetclic/src/domain/ai/ai_base.dart';
import 'package:tictactoebetclic/src/domain/ai/minmax_ia.dart';
import 'package:tictactoebetclic/src/domain/ai/random_ia.dart';

part 'ai_strategy_provider.g.dart';

enum AIStrategyEnum { random, minMax }

@riverpod
class SelectedAIStrategy extends _$SelectedAIStrategy {
  @override
  AIStrategyEnum build() => AIStrategyEnum.random;

  @override
  set state(AIStrategyEnum value) => super.state = value;

  AIBase get aiStrategy => switch (state) {
    AIStrategyEnum.random => ref.read(randomAIProvider),
    AIStrategyEnum.minMax => ref.read(minMaxAIProvider),
  };
}
