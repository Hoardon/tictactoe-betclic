import 'package:flutter_test/flutter_test.dart';

import 'package:tictactoebetclic/src/app.dart';

void main() {
  testWidgets('Simple test', (WidgetTester tester) async {
    await tester.pumpWidget(const TicTacToeApp());
  });
}