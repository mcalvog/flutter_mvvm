import 'dart:async';

import 'package:flutter_mvvm/data/auth/auth_data_impl.dart';
import 'package:flutter_mvvm/domain/auth_repository.dart';
import 'package:flutter_mvvm/view/base/base_view_model.dart';
import 'package:flutter_mvvm/view/base/resource_state.dart';
import 'package:flutter_mvvm/view/common/errorhandling/app_action.dart';
import 'package:flutter_mvvm/view/errorbuilder/auth_error_builder.dart';

class AuthViewModel extends BaseViewModel {
  final AuthRepository _authRepository = AuthDataImpl();

  final StreamController<ResourceState> _loginState =
      StreamController<ResourceState>();
  Stream<ResourceState> get loginState => _loginState.stream;

  final StreamController<bool> _signOutState = StreamController<bool>();
  Stream<bool> get signOutState => _signOutState.stream;

  final StreamController<bool> _authenticatedState = StreamController<bool>();
  Stream<bool> get authenticatedState => _authenticatedState.stream;

  Future<void> login(String user, String password) async {
    _loginState.sink.add(ResourceState.loading());

    _authRepository
        .login(user, password)
        .then((value) => _loginState.sink.add(ResourceState.completed(null)))
        .catchError((e) {
          _loginState.sink.add(ResourceState.error(
              AuthErrorBuilder.create(e, AppAction.SIGN_IN).build()));
        });
  }

  Future<void> isAuthenticated() async {
    _authRepository
        .isAuthenticated()
        .then((value) => _authenticatedState.sink.add(value))
        .onError((error, stackTrace) => _authenticatedState.sink.add(false));
  }

  Future<void> signOut() async {
    _authRepository
        .signOut()
        .then((value) => _signOutState.sink.add(true))
        .onError((error, stackTrace) => _signOutState.sink.add(false));
  }

  @override
  void dispose() {
    _loginState.close();
    _authenticatedState.close();
    _signOutState.close();
  }
}
