import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../core/di/injection.dart';
import 'package:news_app/news_app/core/router/app_router.gr.dart';
import 'package:news_app/news_app/core/services/secure_storage_service.dart';
import 'package:news_app/news_app/core/services/storage_service.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _checkNavigation();
  }

  Future<void> _checkNavigation() async {
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    final storage = getIt<StorageService>();
    final secureStorage = getIt<SecureStorageService>();

    if (storage.isFirstTime()) {
      context.router.replace(const OnboardingRoute());
      return;
    }

    final token = await secureStorage.getToken();
    final isAuth = storage.isAuthorized();

    if (token == null || !isAuth) {
      context.router.replace(const AuthRoute());
    } else {
      context.router.replace(const NewsRoute());
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.newspaper, size: 80, color: Colors.blue),
            SizedBox(height: 20),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}