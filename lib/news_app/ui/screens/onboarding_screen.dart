import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../core/di/injection.dart';
import 'package:news_app/news_app/core/router/app_router.gr.dart';
import 'package:news_app/news_app/core/services/secure_storage_service.dart';
import 'package:news_app/news_app/core/services/storage_service.dart';

@RoutePage()
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  final List<Map<String, String>> _pages = [
    {
      'title': 'Добро пожаловать!',
      'description': 'Читайте самые актуальные и свежие новости со всего мира.'
    },
    {
      'title': 'Категории и Поиск',
      'description': 'Фильтруйте новости по темам и находите то, что интересно вам.'
    },
    {
      'title': 'Начнем?',
      'description': 'Войдите в аккаунт и настройте персональную ленту.'
    },
  ];

  Future<void> _onFinish() async {
    await getIt<StorageService>().setOnboardingCompleted();
    if (!mounted) return;
    context.router.replace(const AuthRoute());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: _pages.length,
                onPageChanged: (index) {
                  setState(() => _currentIndex = index);
                },
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _pages[index]['title']!,
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          _pages[index]['description']!,
                          style: Theme.of(context).textTheme.bodyLarge,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (_currentIndex < _pages.length - 1)
                    TextButton(
                      onPressed: _onFinish,
                      child: const Text('Пропустить'),
                    )
                  else
                    const SizedBox.shrink(),
                  ElevatedButton(
                    onPressed: () {
                      if (_currentIndex < _pages.length - 1) {
                        _controller.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        _onFinish();
                      }
                    },
                    child: Text(_currentIndex == _pages.length - 1 ? 'Начать' : 'Далее'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}