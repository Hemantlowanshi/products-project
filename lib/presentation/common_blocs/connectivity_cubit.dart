import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/services/connectivity_service.dart';

enum ConnectivityStatus { connected, disconnected }

class ConnectivityCubit extends Cubit<ConnectivityStatus> {
  final ConnectivityService _connectivityService;
  StreamSubscription? _subscription;

  ConnectivityCubit(this._connectivityService) : super(ConnectivityStatus.connected) {
    _init();
  }

  void _init() async {
    final isConnected = await _connectivityService.isConnected();
    emit(isConnected ? ConnectivityStatus.connected : ConnectivityStatus.disconnected);

    _subscription = _connectivityService.onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.none) {
        emit(ConnectivityStatus.disconnected);
      } else {
        emit(ConnectivityStatus.connected);
      }
    });
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
