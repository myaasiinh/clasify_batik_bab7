

// buatkan class prin utils mode debug only

import 'package:flutter/foundation.dart';

class PrintLogUtils {
  static void printLog(String message) {
    if (kDebugMode) {
      print(message);
    }
  }
}