import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tictactoebetclic/src/core/utils/logger.dart';

/// Utility class for secure key-value storage
class SecureStorage {
  static final _storage = const FlutterSecureStorage();
  static final _iosOptions = const IOSOptions(
    accessibility: KeychainAccessibility.first_unlock,
  );
  static final _androidOptions = const AndroidOptions(
    encryptedSharedPreferences: true,
  );

  /// Mask sensitive values for logging
  static String _mask(String? value) {
    if (value == null) return "null";
    if (value.isEmpty) return "<empty>";
    if (value.length <= 4) return "*" * value.length;
    return "${value.substring(0, 2)}***${value.substring(value.length - 2)}";
  }

  /// Write a value securely
  @override
  static Future<void> write({
    required String key,
    required String value,
  }) async {
    try {
      await _storage.write(
        key: key,
        value: value,
        iOptions: _iosOptions,
        aOptions: _androidOptions,
      );
      Log.log("SecureStorage.write success on key [$key]: value=${_mask(value)}");
    } catch (e, st) {
      Log.error("SecureStorage.write error on key [$key]: $e\n$st");
      rethrow;
    }
  }

  /// Read a value securely
  static Future<String> read({required String key}) async {
    try {
      final result = await _storage.read(
        key: key,
        iOptions: _iosOptions,
        aOptions: _androidOptions,
      );
      Log.log("SecureStorage.read success on key [$key]: value=${_mask(result)}");
      return result ?? '';
    } catch (e, st) {
      Log.error("SecureStorage.read error on key [$key]: $e\n$st");
      rethrow;
    }
  }

  static Future<bool> containsKeys({required List<String> keys}) async {
    try {
      final results = await Future.wait(
        keys.map(
          (key) async =>
              await _storage.containsKey(key: key, iOptions: _iosOptions),
        ),
      );

      final allExist = results.every((exists) => exists);
      Log.log("SecureStorage: containsKeys(${keys.join(", ")}) -> $allExist");
      return allExist;
    } catch (e, st) {
      Log.error("SecureStorage: containsKeys(${keys.join(", ")}) failed -> $e");
      debugPrintStack(stackTrace: st);
      return false;
    }
  }

  /// Verify if a key exist in actual storage
  static Future<bool> containsKey({required String key}) async {
    try {
      final result = await _storage.containsKey(
        key: key,
        iOptions: _iosOptions,
        aOptions: _androidOptions,
      );
      Log.log("SecureStorage.containsKey success on key [$key]: $result");
      return result;
    } catch (e, st) {
      Log.error("SecureStorage.read error on key [$key]: $e\n$st");
      rethrow;
    }
  }

  /// Read all key/value pairs securely
  static Future<Map<String, String>> readAll() async {
    try {
      final result = await _storage.readAll(
        iOptions: _iosOptions,
        aOptions: _androidOptions,
      );
      final masked = result.map((k, v) => MapEntry(k, _mask(v)));
      Log.log("SecureStorage.readAll success: ${masked.length} items -> $masked");
      return result;
    } catch (e, st) {
      Log.error("SecureStorage.readAll error: $e\n$st");
      rethrow;
    }
  }

  /// Delete a value securely
  static Future<void> delete({required String key}) async {
    try {
      await _storage.delete(
        key: key,
        iOptions: _iosOptions,
        aOptions: _androidOptions,
      );
      Log.log("SecureStorage.delete success on key [$key]");
    } catch (e, st) {
      Log.error("SecureStorage.delete error on key [$key]: $e\n$st");
      rethrow;
    }
  }

  /// Delete all values securely
  static Future<void> reset() async {
    try {
      await _storage.deleteAll();
      Log.log("SecureStorage.reset success: all keys deleted");
    } catch (e, st) {
      Log.error("SecureStorage.reset error: $e\n$st");
      rethrow;
    }
  }
}
