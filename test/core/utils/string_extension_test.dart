import 'package:flutter_test/flutter_test.dart';
import 'package:tictactoebetclic/src/core/utils/string_extension.dart';

void main() {
  group('StringExtension - capitalize', () {
    test('should capitalize the first letter of a lowercase string', () {
      const original = 'hello world';
      final capitalized = original.capitalize;
      expect(capitalized, 'Hello world');
    });

    test('should not change a string that is already capitalized', () {
      const original = 'Flutter';
      final capitalized = original.capitalize;
      expect(capitalized, 'Flutter');
    });

    test('should return an empty string when given an empty string', () {
      const original = '';
      final capitalized = original.capitalize;
      expect(capitalized, '');
    });

    test('should correctly capitalize a single-character string', () {
      const original = 'a';
      final capitalized = original.capitalize;
      expect(capitalized, 'A');
    });

    test('should handle strings with leading numbers or symbols', () {
      const withNumber = '1st place';
      const withSymbol = r'$money';

      final capitalizedNumber = withNumber.capitalize;
      final capitalizedSymbol = withSymbol.capitalize;

      expect(capitalizedNumber, '1st place');
      expect(capitalizedSymbol, r'$money');
    });

    test('should handle strings in all caps', () {
      const original = 'DART IS AWESOME';
      final capitalized = original.capitalize;
      expect(capitalized, 'DART IS AWESOME');
    });
  });
}
