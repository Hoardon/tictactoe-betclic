import 'dart:math';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tictactoebetclic/src/domain/entities/game_state.dart';
import 'package:tictactoebetclic/src/domain/entities/player.dart';
import 'package:tictactoebetclic/src/domain/ai/ai_base.dart';

final randomAIProvider = Provider((ref) => RandomAI());

/// An "easy" AI that chooses a random available cell.
class RandomAI implements AIBase {

  @override
  int makeMove(GameState gameState) {
    final availableMoves = <int>[];

    gameState.board.where((cell) => cell == Player.none).toList();
    for (int i = 0; i < gameState.board.length; i++) {
      if (gameState.board[i] == Player.none) {
        availableMoves.add(i);
      }
    }

    if (availableMoves.isEmpty) {
      // This should not happen in a normal game flow.
      return -1;
    }

    return availableMoves[Random().nextInt(availableMoves.length)];
  }
}
