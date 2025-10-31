import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:tictactoebetclic/src/domain/entities/player.dart';
import 'package:tictactoebetclic/src/presentation/widgets/board_widget.dart';

void main() {
  Widget createTestableWidget({
    required List<Player> board,
    required void Function(int) onCellTap,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: SizedBox(
          height: 500,
          width: 500,
          child: BoardWidget(board: board, onCellTap: onCellTap),
        ),
      ),
    );
  }

  group('BoardWidget Tests', () {
    testWidgets('should render a 3x3 grid of 9 cells', (widgetTester) async {
      await loadAppFonts();

      final emptyBoard = List.filled(9, Player.none);

      await widgetTester.pumpWidget(
        createTestableWidget(board: emptyBoard, onCellTap: (_) {}),
      );
      await widgetTester.pumpAndSettle();

      expect(find.byType(GestureDetector), findsNWidgets(9));
      expect(find.byType(GridView), findsOneWidget);

      await expectLater(
        find.byType(BoardWidget),
        matchesGoldenFile('goldens/emptyBoardGame.png'),
      );
    });

    testWidgets('should display correct icons for each player state', (
      widgetTester,
    ) async {
      await loadAppFonts();

      final board = [Player.X, Player.O, ...List.filled(7, Player.none)];

      await widgetTester.pumpWidget(
        createTestableWidget(board: board, onCellTap: (_) {}),
      );

      expect(find.byIcon(Icons.close), findsOneWidget);
      expect(find.byIcon(Icons.circle_outlined), findsOneWidget);
      expect(find.byIcon(Icons.circle), findsNWidgets(7));

      await expectLater(
        find.byType(BoardWidget),
        matchesGoldenFile('goldens/boardGamePlayerState.png'),
      );
    });

    testWidgets(
      'should call onCellTap with correct index when a cell is tapped',
      (widgetTester) async {
        const int cellToTapIndex = 5;
        int? tappedIndex; // A variable to capture the callback value.
        final board = List.filled(9, Player.none);

        await widgetTester.pumpWidget(
          createTestableWidget(
            board: board,
            onCellTap: (index) {
              tappedIndex = index;
            },
          ),
        );

        await widgetTester.tap(find.byType(GestureDetector).at(cellToTapIndex));

        expect(tappedIndex, cellToTapIndex);
      },
    );

    testWidgets('tapping multiple cells calls onCellTap with correct indices', (
      widgetTester,
    ) async {
      final List<int> tappedIndices = []; // A list to store all tapped indices.
      final board = List.filled(9, Player.none);

      await widgetTester.pumpWidget(
        createTestableWidget(
          board: board,
          onCellTap: (index) {
            tappedIndices.add(index);
          },
        ),
      );

      await widgetTester.tap(find.byType(GestureDetector).at(0));
      await widgetTester.pumpAndSettle();

      expect(tappedIndices, [0]);

      await widgetTester.tap(find.byType(GestureDetector).at(8));
      await widgetTester.pumpAndSettle();

      expect(tappedIndices, [0, 8]);
    });
  });
}
