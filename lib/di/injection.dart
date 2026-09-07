import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/network/dio_client.dart';
import '../core/services/connectivity_service.dart';
import '../core/services/package_info_service.dart';
import '../core/services/storage_service.dart';
import '../data/repositories/auth_repository.dart';
import '../data/services/auth_api_service.dart';
import '../presentation/auth/login/login_cubit.dart';
import '../presentation/splash/splash_cubit.dart';
import '../presentation/common_blocs/connectivity_cubit.dart';

final sl = GetIt.instance;

Future<void> setupDependencies() async {
  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => Connectivity());
  
  final packageInfo = await PackageInfo.fromPlatform();
  sl.registerLazySingleton(() => packageInfo);

  // Services
  sl.registerLazySingleton(() => StorageService(sl()));
  sl.registerLazySingleton(() => ConnectivityService(sl()));
  sl.registerLazySingleton(() => PackageInfoService(sl()));

  // Network
  sl.registerLazySingleton(() => DioClient(sl(), sl()));

  // Data Sources / API Services
  sl.registerLazySingleton(() => AuthApiService(sl()));

  // Repositories
  sl.registerLazySingleton(() => AuthRepository(sl(), sl()));

  // Cubits
  sl.registerFactory(() => SplashCubit(sl()));
  sl.registerFactory(() => LoginCubit(sl()));
  sl.registerLazySingleton(() => ConnectivityCubit(sl()));
}
