import 'package:flutter/material.dart';
import 'package:mobile2you/app/presenter/main_widget/main_widget.dart';
import 'package:mobile2you/shared/utils/close_app.dart';

abstract class AppDependencies {
  static void init() {
    CloseApp.onBackPressed = DateTime.now();

    runApp(const MainWidget());
  }
}
