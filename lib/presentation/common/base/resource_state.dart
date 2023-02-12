import 'package:flutter_mvvm/presentation/common/errorhandling/base/error_bundle.dart';

enum Status { LOADING, SUCCESS, ERROR }

class ResourceState<T> {
  Status status;
  T? data;
  ErrorBundle? error;

  ResourceState._({required this.status, this.data, this.error});

  factory ResourceState.success(T data) =>
      ResourceState._(status: Status.SUCCESS, data: data);

  factory ResourceState.error(ErrorBundle error) =>
      ResourceState._(status: Status.ERROR, error: error);

  factory ResourceState.loading() => ResourceState._(status: Status.LOADING);
}
