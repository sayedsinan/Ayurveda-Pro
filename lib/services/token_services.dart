import 'package:get_storage/get_storage.dart';

class TokenService {
  static final _storage = GetStorage();
  static const String _tokenKey = 'auth_token';

  // Save token
  static Future<void> saveToken(String token) async {
    await _storage.write(_tokenKey, token);
  }

  // Get token
  static String? getToken() {
    return _storage.read(_tokenKey);
  }

  // Remove token (logout)
  static Future<void> removeToken() async {
    await _storage.remove(_tokenKey);
  }

  // Check if user is logged in
  static bool isLoggedIn() {
    return _storage.hasData(_tokenKey);
  }
}