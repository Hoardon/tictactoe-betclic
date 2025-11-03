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
    testWidgets('devrait afficher correctement les scores fournis', (WidgetTester tester) async {
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

    testWidgets('devrait afficher les libellés et les icônes corrects pour chaque catégorie', (WidgetTester tester) async {
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

    testWidgets('devrait gérer correctement la valeur zéro pour tous les scores', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestableWidget(
        wins: 0,
        losses: 0,
        draws: 0,
      ));

      expect(find.text('0'), findsNWidgets(3));
    });

    testWidgets('devrait utiliser Expanded pour espacer les colonnes de manière égale', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestableWidget(
        wins: 1,
        losses: 1,
        draws: 1,
      ));

      final row = tester.widget<Row>(find.byType(Row));
      expect(row.children.length, 3);
      expect(row.children.every((widget) => widget is Expanded), isTrue);
    });

    testWidgets('devrait utiliser FittedBox pour assurer que le texte ne dépasse pas', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestableWidget(
        wins: 1234567890,
        losses: 9876543210,
        draws: 1,
      ));

      expect(find.byType(FittedBox), findsNWidgets(6));
    });
  });
}
