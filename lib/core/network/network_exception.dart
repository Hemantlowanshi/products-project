import 'package:dio/dio.dart';

class NetworkException implements Exception {
  final String message;
  final int? statusCode;

  NetworkException({required this.message, this.statusCode});

  factory NetworkException.fromDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return NetworkException(message: 'Connection timeout. Please check your network.');
      case DioExceptionType.sendTimeout:
        return NetworkException(message: 'Send timeout. Please try again.');
      case DioExceptionType.receiveTimeout:
        return NetworkException(message: 'Receive timeout. Please try again.');
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        switch (statusCode) {
          case 400:
            return NetworkException(message: 'Bad request. Please try again.', statusCode: statusCode);
          case 401:
            return NetworkException(message: 'Invalid username or password.', statusCode: statusCode);
          case 403:
            return NetworkException(message: 'Access denied.', statusCode: statusCode);
          case 404:
            return NetworkException(message: 'Resource not found.', statusCode: statusCode);
          case 500:
            return NetworkException(message: 'Server error. Please try again later.', statusCode: statusCode);
          default:
            return NetworkException(message: 'Something went wrong. Please try again.', statusCode: statusCode);
        }
      case DioExceptionType.cancel:
        return NetworkException(message: 'Request cancelled.');
      case DioExceptionType.connectionError:
        return NetworkException(message: 'No internet connection. Please check your network.');
      default:
        return NetworkException(message: 'An unexpected error occurred.');
    }
  }

  @override
  String toString() => message;
}
