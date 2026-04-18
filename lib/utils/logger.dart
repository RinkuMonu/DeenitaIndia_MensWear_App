import 'package:flutter/foundation.dart';

/// Debug-only log
void logDebug(dynamic message) {
  if (kDebugMode) {
    // ignore: avoid_print
    print(message);
  }
}

/// Debug-only error log
void logError(dynamic message) {
  if (kDebugMode) {
    // ignore: avoid_print
    print("❌ ERROR: $message");
  }
}

/// Assert-based log (100% removed in release)
void logAssert(dynamic message) {
  assert(() {
    // ignore: avoid_print
    print(message);
    return true;
  }());
}
