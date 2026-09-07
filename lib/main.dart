import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'core/routes/app_routes.dart';
import 'core/routes/route_generator.dart';
import 'core/widgets/no_internet_widget.dart';
import 'di/injection.dart';
import 'presentation/common_blocs/connectivity_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I<ConnectivityCubit>(),
      child: MaterialApp(
        title: 'MVVM Arch Flutter',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.blue,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        ),
        builder: (context, child) {
          return BlocBuilder<ConnectivityCubit, ConnectivityStatus>(
            builder: (context, state) {
              if (state == ConnectivityStatus.disconnected) {
                return const Scaffold(body: NoInternetWidget());
              }
              return child!;
            },
          );
        },
        initialRoute: AppRoutes.splash,
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
