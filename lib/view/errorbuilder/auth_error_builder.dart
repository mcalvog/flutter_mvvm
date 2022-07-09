import 'dart:async';
import 'dart:io';

import 'package:flutter_mvvm/model/exception/http_exception.dart';
import 'package:flutter_mvvm/view/common/errorhandling/app_action.dart';
import 'package:flutter_mvvm/view/common/errorhandling/app_error.dart';
import 'package:flutter_mvvm/view/common/errorhandling/error_bundle.dart';
import 'package:flutter_mvvm/view/common/errorhandling/error_bundle_builder.dart';

class AuthErrorBuilder extends ErrorBundleBuilder {
  AuthErrorBuilder.create(Exception exception, AppAction appAction) : super.create(exception, appAction);

  @override
  ErrorBundle handle(HTTPException exception, AppAction appAction) {
    String stringId = 'error_default';
    AppError appError = AppError.UNKNOWN;

    switch(exception.statusCode) {
      case 500:
        stringId = 'error_server';
        break;
    }

    return ErrorBundle(exception, stringId, appAction, appError);
  }

}