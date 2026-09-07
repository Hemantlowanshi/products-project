import '../../core/network/dio_client.dart';
import '../../core/constants/api_constants.dart';

class AuthApiService {
  final DioClient _dioClient;

  AuthApiService(this._dioClient);

  Future<Map<String, dynamic>> login({
    required String username,
    required String password,
  }) async {
    try {
      final response = await _dioClient.post(
        ApiConstants.login,
        data: {
          'username': username,
          'password': password,
          'expiresInMins': 30,
        },
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
