import 'package:flutter_mvvm/data/remote/credentials_wallet.dart';
import 'package:flutter_mvvm/data/remote/http_client.dart';
import 'package:flutter_mvvm/data/remote/network_endpoints.dart';

import '../../remote/base/error/remote_error_mapper.dart';

class AuthRemoteImpl {
  final httpClient = HttpClient();

  Future<void> login(String user, String password) async {
    try {
      dynamic response = await httpClient.dio.post(
        NetworkEndpoints.loginUrl,
        data: {'user': user, 'password': password},
      );

      await CredentialsWallet.saveAll(response.data);
    } on Exception catch (e) {
      throw RemoteErrorMapper.getException(e);
    }
  }

  Future<bool> isAuthenticated() async {
    final refreshToken = await CredentialsWallet.getRefreshToken();
    return !refreshToken.isEmpty;
  }

  Future<void> signOut() async {
    CredentialsWallet.clearAll();
  }
}
