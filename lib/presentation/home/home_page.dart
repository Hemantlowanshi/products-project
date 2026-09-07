import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../core/routes/app_routes.dart';
import '../../core/services/package_info_service.dart';
import '../../data/repositories/auth_repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authRepository = GetIt.I<AuthRepository>();
    final packageInfo = GetIt.I<PackageInfoService>();
    final user = authRepository.getCurrentUser();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await authRepository.logout();
              if (context.mounted) {
                Navigator.pushReplacementNamed(context, AppRoutes.login);
              }
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (user?.image != null)
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(user!.image),
                ),
              const SizedBox(height: 16),
              Text(
                'Welcome, ${user?.firstName ?? ''} ${user?.lastName ?? ''}!',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(user?.email ?? ''),
              const SizedBox(height: 32),
              const Divider(),
              const SizedBox(height: 16),
              Text('App Version: ${packageInfo.version}'),
              Text('Package Name: ${packageInfo.packageName}'),
            ],
          ),
        ),
      ),
    );
  }
}
