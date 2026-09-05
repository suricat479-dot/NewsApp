import 'package:flutter/material.dart';
import '../../domain/entities/article.dart';
import '../../domain/usecases/get_top_headlines.dart';

class NewsProvider extends ChangeNotifier {
  final GetTopHeadlines getTopHeadlinesUseCase;

  List<Article> _articles = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Article> get articles => _articles;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  NewsProvider({required this.getTopHeadlinesUseCase});

  Future<void> fetchNews() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _articles = await getTopHeadlinesUseCase();
    } catch (e) {
      _errorMessage = 'Не удалось загрузить новости. Проверьте соединение.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}