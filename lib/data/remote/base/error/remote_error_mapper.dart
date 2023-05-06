import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../model/exception/http_exception.dart';

class RemoteErrorMapper {
  RemoteErrorMapper();

  static Exception getException(dynamic error) {
    switch (error.runtimeType) {
      case DioError:
        switch (error.type) {
          case DioErrorType.connectionTimeout:
            return TimeoutException(error.message);
          case DioErrorType.sendTimeout:
            return TimeoutException(error.message);
          case DioErrorType.receiveTimeout:
            return TimeoutException(error.message);
          case DioErrorType.badResponse:
            return HTTPException(error.response?.statusCode ?? -1,
                error.response?.data.toString() ?? "");
          case DioErrorType.unknown:
            if (error.error.toString().contains("SocketException")) {
              return SocketException(error.error.toString());
            }

            return Exception();
          default:
            return Exception();
        }
      case TypeError:
        return Exception('Type error');
      default:
        return error is Exception ? error : Exception();
    }
  }
}
