import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../model/exception/http_exception.dart';

class RemoteErrorMapper {
  RemoteErrorMapper();

  static Exception getException(Exception exception) {
    if (exception is DioError) {
      switch (exception.type) {
        case DioErrorType.connectTimeout:
          return TimeoutException(exception.message);
        case DioErrorType.sendTimeout:
          return TimeoutException(exception.message);
        case DioErrorType.receiveTimeout:
          return TimeoutException(exception.message);
        case DioErrorType.response:
          return HTTPException(
              exception.response?.statusCode ?? -1, exception.response?.data.toString() ?? "");
        case DioErrorType.other:
          if (exception.message.contains("SocketException")) {
            return SocketException(exception.message);
          }

          return Exception();
        default:
          return Exception();
      }
    }

    return exception;
  }
}
