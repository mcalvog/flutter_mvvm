import 'dart:async';

import 'package:flutter_mvvm/data/auth/auth_data_impl.dart';
import 'package:flutter_mvvm/domain/auth_repository.dart';
import 'package:flutter_mvvm/view/base/base_view_model.dart';
import 'package:flutter_mvvm/view/base/resource_state.dart';
import 'package:flutter_mvvm/view/common/errorhandling/app_action.dart';
import 'package:flutter_mvvm/view/errorbuilder/auth_error_builder.dart';

class AuthViewModel extends BaseViewModel {
  final AuthRepository _authRepository = AuthDataImpl();

  StreamController<ResourceState> loginState =
      StreamController<ResourceState>();

  StreamController<bool> signOutState = StreamController<bool>();

  StreamController<bool> authenticatedState = StreamController<bool>();

  Future<void> login(String user, String password) async {
    loginState.add(ResourceState.loading());

    _authRepository
        .login(user, password)
        .then((value) => loginState.add(ResourceState.completed(null)))
        .catchError((e) {
          loginState.add(ResourceState.error(
              AuthErrorBuilder.create(e, AppAction.SIGN_IN).build()));
        });
  }

  Future<void> isAuthenticated() async {
    _authRepository
        .isAuthenticated()
        .then((value) => authenticatedState.add(value))
        .onError((error, stackTrace) => authenticatedState.add(false));
  }

  Future<void> signOut() async {
    _authRepository
        .signOut()
        .then((value) => signOutState.add(true))
        .onError((error, stackTrace) => signOutState.add(false));
  }

  @override
  void dispose() {
    loginState.close();
    authenticatedState.close();
  }
}
