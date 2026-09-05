import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'package:news_app/news app/ui/screens/news_screen.dart';
import 'package:news_app/news app/ui/providers/news_provider.dart';
import 'package:news_app/news app/domain/usecases/get_top_headlines.dart';
import 'package:news_app/news app/data/repositories/news_repository_impl.dart';
import 'package:news_app/news app/data/data_source/remote/news_data_source_impl.dart';
void main() {
  final httpClient = http.Client();
  final remoteDataSource = NewsRemoteDataSourceImpl(client: httpClient);
  final repository = NewsRepositoryImpl(remoteDataSource: remoteDataSource);
  final getTopHeadlines = GetTopHeadlines(repository);

  runApp(
    ChangeNotifierProvider(
      create: (_) => NewsProvider(getTopHeadlinesUseCase: getTopHeadlines)..fetchNews(),
      child: const MyApp(),
    ),
  );
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
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: const NewsScreen(),
    );
  }
}