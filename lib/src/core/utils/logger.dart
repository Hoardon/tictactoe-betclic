import 'package:logger/logger.dart';

class Log {
  static void log(dynamic msg) => Logger().d(msg);

  static void warning(dynamic msg) => Logger().w(msg);

  static void error(dynamic msg) => Logger().e(msg);
}