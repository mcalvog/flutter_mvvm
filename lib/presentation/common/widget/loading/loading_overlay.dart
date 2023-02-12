import 'package:flutter/material.dart';

class LoadingOverlay {
  static var isLoading = false;
  BuildContext _context;

  LoadingOverlay._create(this._context);

  factory LoadingOverlay.of(BuildContext context) {
    return LoadingOverlay._create(context);
  }

  void show() async {
    if (isLoading) return;

    showDialog(
      context: _context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () => Future.value(false),
          child: const Center(child: CircularProgressIndicator()),
        );
      },
    );

    isLoading = true;
  }

  void hide() {
    if (!isLoading) return;
    Navigator.of(_context).pop();
    isLoading = false;
  }
}