import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:tictactoebetclic/src/domain/entities/record_game.dart';
import 'package:tictactoebetclic/src/presentation/widgets/user_history_card_widget.dart';

void main() {
  setUpAll(() async {
    await loadAppFonts();
  });

  Widget buildTestableWidget({required RecordGame recordGame}) {
    return MaterialApp(
      home: Scaffold(body: UserHistoryCard(recordGame: recordGame)),
    );
  }

  group('UserScoreCard', () {
    testWidgets('Victory AI', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          recordGame: RecordGame(
            status: RecordGameStatus.victory,
            opponent: OpponentType.ai,
            datetime: DateTime.utc(2025),
          ),
        ),
      );

      expect(find.text(RecordGameStatus.victory.label), findsOneWidget);
      expect(find.textContaining(OpponentType.ai.label), findsOneWidget);

      await expectLater(
        find.byType(UserHistoryCard),
        matchesGoldenFile('goldens/userHistoryCardVictoryAI.png'),
      );
    });

    testWidgets('Loss AI', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          recordGame: RecordGame(
            status: RecordGameStatus.loss,
            opponent: OpponentType.ai,
            datetime: DateTime.utc(2025),
          ),
        ),
      );

      expect(find.text(RecordGameStatus.loss.label), findsOneWidget);
      expect(find.textContaining(OpponentType.ai.label), findsOneWidget);

      await expectLater(
        find.byType(UserHistoryCard),
        matchesGoldenFile('goldens/userHistoryCardLossAI.png'),
      );
    });

    testWidgets('Draw AI', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          recordGame: RecordGame(
            status: RecordGameStatus.draw,
            opponent: OpponentType.ai,
            datetime: DateTime.utc(2025),
          ),
        ),
      );

      expect(find.text(RecordGameStatus.draw.label), findsOneWidget);
      expect(find.textContaining(OpponentType.ai.label), findsOneWidget);

      await expectLater(
        find.byType(UserHistoryCard),
        matchesGoldenFile('goldens/userHistoryCardDrawAI.png'),
      );
    });

    testWidgets('Victory Human', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          recordGame: RecordGame(
            status: RecordGameStatus.victory,
            opponent: OpponentType.human,
            datetime: DateTime.utc(2025),
          ),
        ),
      );

      expect(find.text(RecordGameStatus.victory.label), findsOneWidget);
      expect(find.textContaining(OpponentType.human.label), findsOneWidget);

      await expectLater(
        find.byType(UserHistoryCard),
        matchesGoldenFile('goldens/userHistoryCardVictoryHuman.png'),
      );
    });

    testWidgets('Loss Human', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          recordGame: RecordGame(
            status: RecordGameStatus.loss,
            opponent: OpponentType.human,
            datetime: DateTime.utc(2025),
          ),
        ),
      );

      expect(find.text(RecordGameStatus.loss.label), findsOneWidget);
      expect(find.textContaining(OpponentType.human.label), findsOneWidget);

      await expectLater(
        find.byType(UserHistoryCard),
        matchesGoldenFile('goldens/userHistoryCardLossHuman.png'),
      );
    });

    testWidgets('Draw Human', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          recordGame: RecordGame(
            status: RecordGameStatus.draw,
            opponent: OpponentType.human,
            datetime: DateTime.utc(2025),
          ),
        ),
      );

      expect(find.text(RecordGameStatus.draw.label), findsOneWidget);
      expect(find.textContaining(OpponentType.human.label), findsOneWidget);

      await expectLater(
        find.byType(UserHistoryCard),
        matchesGoldenFile('goldens/userHistoryCardDrawHuman.png'),
      );
    });
  });
}
