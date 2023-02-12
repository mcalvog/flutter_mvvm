import 'package:flutter/material.dart';
import 'package:flutter_mvvm/presentation/common/errorhandling/base/error_bundle.dart';
import 'package:flutter_mvvm/presentation/common/localization/localization.dart';

class ErrorOverlay {
  BuildContext _context;

  ErrorOverlay._create(this._context);

  factory ErrorOverlay.of(BuildContext context) {
    return ErrorOverlay._create(context);
  }

  void show(ErrorBundle? error, {VoidCallback? onRetry}) {
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
                child: Text(Localization.of(context).string('action_ok')),
                onPressed: () {
                  Navigator.of(_context).pop();
                },
              ),
              Visibility(
                visible: onRetry != null,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(_context).pop();
                    onRetry?.call();
                  },
                  child: Text(Localization.of(context).string('action_retry')),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}