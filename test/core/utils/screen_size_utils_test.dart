import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tictactoebetclic/src/core/utils/screen_size_utils.dart';

void main() {
  group('ScreenSize Extension on BuildContext', () {
    const testScreenSize = Size(320, 480);

    testWidgets('screenHeight() should return the height from MediaQuery',
            (WidgetTester tester) async {

          double? capturedHeight;
          double? capturedWidth;

          await tester.pumpWidget(
            MaterialApp(
              home: MediaQuery(
                data: const MediaQueryData(size: testScreenSize),
                child: Builder(
                  builder: (BuildContext context) {
                    capturedHeight = context.screenHeight();
                    capturedWidth = context.screenWidth();

                    return const SizedBox.shrink();
                  },
                ),
              ),
            ),
          );

          expect(capturedHeight, isNotNull);
          expect(capturedHeight, testScreenSize.height);
          expect(capturedWidth, testScreenSize.width);
        });
  });
}