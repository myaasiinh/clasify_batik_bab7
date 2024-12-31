// Import Flutter's foundation library, which provides debugging-related features
import 'package:flutter/foundation.dart';

// Utility class for printing logs only in debug mode
class PrintLogUtils {
  // Static method to print a log message
  static void printLog(String message) {
    // Check if the application is running in debug mode
    if (kDebugMode) {
      // Print the provided message to the console
      print(message);
    }
  }
}
