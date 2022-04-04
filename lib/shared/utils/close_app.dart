import 'dart:io';

import 'package:flutter/services.dart';

abstract class CloseApp {
  static void close() {
    print(" ========================= CLOSE"); // TODO
    return;
    try {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      SystemNavigator.pop();
      exit(0);
      // ignore: empty_catches
    } catch (e) {}
  }

  static void doubleBackToClose({
    Duration timer = const Duration(seconds: 2),
    void Function()? notification,
  }) {
    DateTime now = DateTime.now();
    if (now.difference(onBackPressed) > timer) {
      onBackPressed = now;
      notification?.call();
      return;
    }
    CloseApp.close();
  }

  static DateTime onBackPressed = DateTime.now();
}
