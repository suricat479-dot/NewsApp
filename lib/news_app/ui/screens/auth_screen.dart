import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../core/di/injection.dart';
import '../../core/router/app_router.gr.dart';
import '../../../news app/data/datasources/local/secure_storage_service.dart';
import '../../../news app/data/datasources/local/storage_service.dart';

@RoutePage()
class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _login() async {
    setState(() => _isLoading = true);

    await Future.delayed(const Duration(seconds: 1));

    await getIt<SecureStorageService>().saveToken('dummy_auth_token_12345');
    await getIt<StorageService>().setAuthorized(true);

    if (!mounted) return;
    context.router.replace(const NewsRoute());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Авторизация')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Пароль',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _login,
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Войти'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}