import 'package:flutter/material.dart';

class LoadingOverlay {
  BuildContext _context;

  LoadingOverlay._create(this._context);

  factory LoadingOverlay.of(BuildContext context) {
    return LoadingOverlay._create(context);
  }

  void hide() {
    Navigator.of(_context).pop();
  }

  void show() {
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
  }
}
