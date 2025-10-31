import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoebetclic/src/domain/ai/ai_base.dart';
import 'package:tictactoebetclic/src/domain/ai/minmax_ia.dart';
import 'package:tictactoebetclic/src/domain/ai/random_ia.dart';

part 'ai_strategy_provider.g.dart';

enum AIStrategyEnum { easy, hard }

@Riverpod(keepAlive: true)
class SelectedAIStrategy extends _$SelectedAIStrategy {
  @override
  AIStrategyEnum build() => AIStrategyEnum.easy;

  @override
  set state(AIStrategyEnum value) => super.state = value;

  AIBase get aiStrategy => switch (state) {
    AIStrategyEnum.easy => ref.read(randomAIProvider),
    AIStrategyEnum.hard => ref.read(minMaxAIProvider),
  };
}
