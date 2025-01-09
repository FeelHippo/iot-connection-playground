import 'package:flutter/material.dart';

/// App Dashboard Controller
class DashboardController {
  /// Tell the framework to not send the first frames to the engine until there
  /// is a corresponding call to allowFirstFrame
  static void preserve() =>
      WidgetsFlutterBinding.ensureInitialized()..deferFirstFrame();

  /// Called after deferFirstFrame to tell the framework that it is ok to send
  /// the first frame to the engine now
  static void remove() {
    if (!WidgetsFlutterBinding.ensureInitialized().sendFramesToEngine) {
      WidgetsFlutterBinding.ensureInitialized().allowFirstFrame();
    }
  }
}
