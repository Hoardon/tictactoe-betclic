import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tictactoebetclic/src/domain/states/ai_game_state.dart';

void main() {
  group('AIGameState Notifier', () {
    test('initial state should be false', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final initialState = container.read(aIGameStateProvider);

      expect(initialState, isFalse);
    });

    test('state can be updated to true', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(aIGameStateProvider.notifier);
      notifier.state = true;

      final updatedState = container.read(aIGameStateProvider);
      expect(updatedState, isTrue);
    });

    test('state can be updated from true back to false', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      container.read(aIGameStateProvider.notifier).state = true;

      container.read(aIGameStateProvider.notifier).state = false;

      final finalState = container.read(aIGameStateProvider);
      expect(finalState, isFalse);
    });
  });
}
