import 'package:flutter/material.dart';
import 'package:flutter_mvvm/view/common/errorhandling/error_bundle.dart';
import 'package:flutter_mvvm/view/common/localization/localization.dart';

class ErrorOverlay {
  BuildContext _context;

  ErrorOverlay._create(this._context);

  factory ErrorOverlay.of(BuildContext context) {
    return ErrorOverlay._create(context);
  }

  void show(ErrorBundle? error) {
    if (error == null) {
      return;
    }

    showDialog(
      context: _context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () => Future.value(false),
          child: AlertDialog(
            title: Text(Localization.of(context).string('error_title')),
            content: Text(Localization.of(context).string(error.stringId)),
            actions: [
              TextButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.of(_context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
