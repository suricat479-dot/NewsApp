import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'news_app/core/di/injection.dart';
import 'news_app/core/router/app_router.dart';
import 'news_app/ui/providers/news_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Получаем экземпляр роутера из GetIt
    final appRouter = getIt<AppRouter>();

    return ChangeNotifierProvider(
      create: (_) => getIt<NewsProvider>(),
      child: MaterialApp.router(
        title: 'News App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
          scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        ),
        routerConfig: appRouter.config(),
      ),
    );
  }
}