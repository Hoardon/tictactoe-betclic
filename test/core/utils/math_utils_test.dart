import 'package:flutter_test/flutter_test.dart';

// Assume these functions are in a file you can import.
// For this self-contained example, I'll place them directly here.
int max(int a, int b) => a > b ? a : b;
int min(int a, int b) => a < b ? a : b;

void main() {
  group('max function', () {
    test('should return the greater value when the first argument is larger', () {
      const a = 10;
      const b = 5;

      final result = max(a, b);

      expect(result, 10);
    });

    test('should return the greater value when the second argument is larger', () {
      const a = -5;
      const b = 5;

      final result = max(a, b);

      expect(result, 5);
    });

    test('should return the value when both arguments are equal', () {
      const a = 7;
      const b = 7;

      final result = max(a, b);

      expect(result, 7);
    });

    test('should work correctly with negative numbers', () {
      const a = -10;
      const b = -20;

      final result = max(a, b);

      expect(result, -10);
    });
  });

  group('min function', () {
    test('should return the smaller value when the first argument is smaller', () {
      const a = 3;
      const b = 8;

      final result = min(a, b);

      expect(result, 3);
    });

    test('should return the smaller value when the second argument is smaller', () {
      const a = 15;
      const b = 4;

      final result = min(a, b);

      expect(result, 4);
    });

    test('should return the value when both arguments are equal', () {
      const a = -5;
      const b = -5;

      final result = min(a, b);

      expect(result, -5);
    });

    test('should work correctly with a mix of positive and negative numbers', () {
      const a = -100;
      const b = 1;

      final result = min(a, b);

      expect(result, -100);
    });
  });
}