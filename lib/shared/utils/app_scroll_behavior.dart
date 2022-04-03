import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// ? This class allows to scroll on desktop like on mobile
class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
