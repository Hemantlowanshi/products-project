import 'dart:convert';
import 'package:dio/dio.dart';
import '../../core/network/network_exception.dart';
import '../../core/services/storage_service.dart';
import '../models/login_model.dart';
import '../services/auth_api_service.dart';

class AuthRepository {
  final AuthApiService _apiService;
  final StorageService _storageService;

  AuthRepository(this._apiService, this._storageService);

  Future<LoginModel> login({
    required String username,
    required String password,
  }) async {
    try {
      final data = await _apiService.login(username: username, password: password);
      final loginModel = LoginModel.fromJson(data);
      
      await _storageService.saveAccessToken(loginModel.accessToken);
      await _storageService.saveRefreshToken(loginModel.refreshToken);
      await _storageService.saveUser(jsonEncode(loginModel.toJson()));
      
      return loginModel;
    } on DioException catch (e) {
      throw NetworkException.fromDioError(e);
    } catch (e) {
      throw Exception('An unexpected error occurred during login');
    }
  }

  Future<void> logout() async {
    await _storageService.clear();
  }

  String? getAccessToken() {
    return _storageService.getAccessToken();
  }

  bool isLoggedIn() {
    return _storageService.hasSession();
  }

  LoginModel? getCurrentUser() {
    final userJson = _storageService.getUser();
    if (userJson != null) {
      return LoginModel.fromJson(jsonDecode(userJson));
    }
    return null;
  }
}
