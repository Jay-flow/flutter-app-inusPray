import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class DLog {
  DLog._();
  static final _logger = Logger(
    printer: PrettyPrinter(),
  );

  static void d(message) {
    return _logger.d(message);
  }

  static void e(message) {
    return _logger.e(message);
  }

  static void i(message) {
    return _logger.i(message);
  }

  static void w(message) {
    return _logger.w(message);
  }

  static final _loggerNoStack = Logger(
    printer: PrettyPrinter(methodCount: 0),
  );

  static void noStackI(message) {
    _loggerNoStack.i(message);
  }

  static void noStackW(message) {
    _loggerNoStack.w(message);
  }

  static void noStackV({key, @required message}) {
    _loggerNoStack.v(key, message);
  }
}
