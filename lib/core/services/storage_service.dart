import 'package:shared_preferences/shared_preferences.dart';
import '../constants/storage_keys.dart';

class StorageService {
  final SharedPreferences _prefs;

  StorageService(this._prefs);

  Future<void> saveAccessToken(String token) async {
    await _prefs.setString(StorageKeys.accessToken, token);
  }

  String? getAccessToken() {
    return _prefs.getString(StorageKeys.accessToken);
  }

  Future<void> saveRefreshToken(String token) async {
    await _prefs.setString(StorageKeys.refreshToken, token);
  }

  String? getRefreshToken() {
    return _prefs.getString(StorageKeys.refreshToken);
  }

  Future<void> removeTokens() async {
    await _prefs.remove(StorageKeys.accessToken);
    await _prefs.remove(StorageKeys.refreshToken);
    await _prefs.remove(StorageKeys.user);
  }

  Future<void> saveUser(String userJson) async {
    await _prefs.setString(StorageKeys.user, userJson);
  }

  String? getUser() {
    return _prefs.getString(StorageKeys.user);
  }

  Future<void> clear() async {
    await _prefs.clear();
  }

  bool hasSession() {
    return getAccessToken() != null;
  }
}
