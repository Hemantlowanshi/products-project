import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/auth_repository.dart';
import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final AuthRepository _authRepository;

  SplashCubit(this._authRepository) : super(SplashInitial());

  Future<void> checkAuthentication() async {
    emit(SplashLoading());
    try {
      await Future.delayed(const Duration(seconds: 2)); // Simulate splash delay
      if (_authRepository.isLoggedIn()) {
        emit(SplashAuthenticated());
      } else {
        emit(SplashUnauthenticated());
      }
    } catch (e) {
      emit(SplashFailure('An error occurred during authentication check'));
    }
  }
}
