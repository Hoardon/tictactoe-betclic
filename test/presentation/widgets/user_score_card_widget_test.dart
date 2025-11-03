import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tictactoebetclic/src/presentation/widgets/user_score_card_widget.dart';

void main() {
  Widget buildTestableWidget({
    required int wins,
    required int losses,
    required int draws,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: UserScoreCard(
          wins: wins,
          losses: losses,
          draws: draws,
        ),
      ),
    );
  }

  group('UserScoreCard', () {
    testWidgets('should display correctly UserScoreCard', (WidgetTester tester) async {
      const testWins = 10;
      const testLosses = 5;
      const testDraws = 2;

      await tester.pumpWidget(buildTestableWidget(
        wins: testWins,
        losses: testLosses,
        draws: testDraws,
      ));

      expect(find.text(testWins.toString()), findsOneWidget);
      expect(find.text(testLosses.toString()), findsOneWidget);
      expect(find.text(testDraws.toString()), findsOneWidget);
    });

    testWidgets('should display icons and labels with category', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestableWidget(
        wins: 1,
        losses: 2,
        draws: 3,
      ));

      expect(find.text('WINS'), findsOneWidget);
      expect(find.text('LOSSES'), findsOneWidget);
      expect(find.text('DRAWS'), findsOneWidget);

      expect(find.byIcon(Icons.emoji_events), findsOneWidget);
      expect(find.byIcon(Icons.thumb_down), findsOneWidget);
      expect(find.byIcon(Icons.handshake), findsOneWidget);
    });

    testWidgets('should print 0 on each score', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestableWidget(
        wins: 0,
        losses: 0,
        draws: 0,
      ));

      expect(find.text('0'), findsNWidgets(3));
    });
  });
}
