import 'package:shared_preferences/shared_preferences.dart';

class CredentialsWallet {
  static const refreshTokenKey = 'refresh_token';
  static const accessTokenKey = 'access_token';
  static const expiresInKey = 'expires_in';

  static getRefreshToken() async {
    return await _getString(refreshTokenKey);
  }

  static getAccessToken() async {
    return await _getString(accessTokenKey);
  }

  static getExpirationTimeStamp() async {
    return await _getInt(expiresInKey);
  }

  static saveRefreshToken(String refreshToken) async {
    await _storeString(refreshTokenKey, refreshToken);
  }

  static saveAccessToken(String refreshToken) async {
    await _storeString(accessTokenKey, refreshToken);
  }

  static saveExpirationTimeStamp(int expiresIn) async {
    // Current date in millis + expiration in millis - 5 minutes in millis
    await _storeInt(expiresInKey, (DateTime.now().millisecondsSinceEpoch + (expiresIn * 1000) - 300000));
  }

  static saveAll(dynamic jsonDecode) async {
    await saveRefreshToken(jsonDecode[refreshTokenKey]);
    await saveAccessToken(jsonDecode[accessTokenKey]);
    await saveExpirationTimeStamp(jsonDecode[expiresInKey]);
  }

  static clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(refreshTokenKey);
    await prefs.remove(accessTokenKey);
    await prefs.remove(expiresInKey);
  }

  static _storeString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  static _getString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? '';
  }

  static _storeInt(String key, int value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, value);
  }

  static _getInt(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key) ?? 0;
  }
}
