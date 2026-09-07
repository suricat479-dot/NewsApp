import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:news_app/news app/ui/screens/news_screen.dart';
import 'package:news_app/news app/ui/providers/news_provider.dart';
import 'package:news_app/news app/core/di/injection.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Инициализация DI граф зависимостей (GetIt + Injectable)
  configureDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF7F8FA),
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: ChangeNotifierProvider(
        create: (_) => getIt<NewsProvider>()..fetchNews(),
        child: const NewsScreen(),
      ),
    );
  }
}