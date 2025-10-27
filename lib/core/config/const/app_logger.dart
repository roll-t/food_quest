import 'package:logger/logger.dart';

class AppLogger {
  static Logger? _logger;

  static void init() {
    if (_logger != null) return;

    const env = String.fromEnvironment('ENV', defaultValue: 'dev');
    _logger = Logger(
      level: _mapEnvToLogLevel(env),
      printer: PrettyPrinter(
        methodCount: 2,
        errorMethodCount: 5,
        colors: true,
        printEmojis: true,
      ),
    );
    i('[AppLogger] Logger initialized for ENV: $env');
  }

  static void setLogger(Logger logger) {
    if (_logger != null) return;
    _logger = logger;
  }

  static void i(dynamic message) => _logger?.i(message);
  static void d(dynamic message) => _logger?.d(message);
  static void w(dynamic message) => _logger?.w(message);
  static void e(dynamic message) => _logger?.e(message);

  static Level _mapEnvToLogLevel(String env) {
    switch (env) {
      case 'prod':
        // ignore: deprecated_member_use
        return Level.nothing;
      case 'profile':
        return Level.info;
      case 'dev':
      default:
        return Level.debug;
    }
  }
}
