import 'package:flutter_mvvm/view/common/errorhandling/app_action.dart';
import 'package:flutter_mvvm/view/common/errorhandling/app_error.dart';

class ErrorBundle {
  final Exception exception;
  final String stringId;
  final AppAction appAction;
  final AppError appError;

  ErrorBundle(this.exception, this.stringId, this.appAction, this.appError);

  String get message {
    return exception.toString();
  }
}
