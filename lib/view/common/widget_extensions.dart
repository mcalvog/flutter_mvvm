import 'package:flutter/material.dart';

extension NavigationExtensions on BuildContext {
  void navigateTo(Widget widget) {
    Navigator.push(this, MaterialPageRoute(builder: (_) => widget));
  }

  void navigateReplacing(Widget widget) {
    Navigator.pushReplacement(this, MaterialPageRoute(builder: (_) => widget));
  }
}
