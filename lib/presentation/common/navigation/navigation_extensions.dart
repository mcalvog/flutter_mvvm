import 'package:flutter/material.dart';

extension NavigationExtensions on BuildContext {
  /// Navigate to a new screen.
  void navigateTo(Widget widget) {
    Navigator.push(this, MaterialPageRoute(builder: (_) => widget));
  }

  /// Navigate to a new screen, replacing the current one.
  void navigateReplacing(Widget widget) {
    Navigator.pushReplacement(this, MaterialPageRoute(builder: (_) => widget));
  }

  /// Navigate to a new screen, replacing all previous screens.
  void navigatePopReplacing(Widget widget) {
    Navigator.pushAndRemoveUntil(this, MaterialPageRoute(builder: (_) => widget), (route) => false);
  }
}