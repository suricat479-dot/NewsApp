import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:news_app/news app/ui/screens/splash_page.dart';
import 'package:news_app/news app/ui/providers/news_provider.dart';
import 'package:news_app/news app/core/di/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => getIt<NewsProvider>(),
      child: MaterialApp(
        title: 'News App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
          scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        ),
        home: const SplashPage(),
      ),
    );
  }
}