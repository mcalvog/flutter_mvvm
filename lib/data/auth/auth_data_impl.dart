import 'package:flutter_mvvm/data/auth/remote/auth_remote_impl.dart';
import 'package:flutter_mvvm/domain/auth_repository.dart';

class AuthDataImpl implements AuthRepository {
  final AuthRemoteImpl _remoteImpl = AuthRemoteImpl();

  @override
  Future<void> login(String user, String password) {
    return _remoteImpl.login(user, password);
  }

  @override
  Future<bool> isAuthenticated() {
    return _remoteImpl.isAuthenticated();
  }

  @override
  Future<void> signOut() {
    return _remoteImpl.signOut();
  }
}
