import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../core/di/injection.dart';
import 'package:news_app/news_app/core/router/app_router.gr.dart';
import 'package:news_app/news_app/core/services/secure_storage_service.dart';
import 'package:news_app/news_app/core/services/storage_service.dart';
@RoutePage()
class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  Future<void> _logout(BuildContext context) async {
    await getIt<SecureStorageService>().clearAll();
    await getIt<StorageService>().setAuthorized(false);

    if (!context.mounted) return;
    context.router.replaceAll([const AuthRoute()]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Профиль')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            
            SizedBox(
              height: 120,
              width: 120,
              child: Lottie.asset(
                'assets/vending_machine.json',
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Пользователь',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () => _logout(context),
                child: const Text('Выйти', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}