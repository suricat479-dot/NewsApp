import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/article.dart';
import '../../domain/usecases/get_top_headlines.dart';
import '../../domain/usecases/search_news.dart';

@injectable
class NewsProvider extends ChangeNotifier {
  final GetTopHeadlines getTopHeadlinesUseCase;
  final SearchNews searchNewsUseCase;

  NewsProvider({
    required this.getTopHeadlinesUseCase,
    required this.searchNewsUseCase,
  });

  List<Article> _articles = [];
  List<Article> _searchResults = [];
  bool _isLoading = false;
  bool _isSearching = false;
  String? _errorMessage;

  List<Article> get articles => _articles;
  List<Article> get searchResults => _searchResults;
  bool get isLoading => _isLoading;
  bool get isSearching => _isSearching;
  String? get errorMessage => _errorMessage;

  Future<void> fetchTopHeadlines() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _articles = await getTopHeadlinesUseCase();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> search(String query) async {
    if (query.trim().isEmpty) {
      _searchResults = [];
      _isSearching = false;
      notifyListeners();
      return;
    }

    _isSearching = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _searchResults = await searchNewsUseCase(query);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isSearching = false;
      notifyListeners();
    }
  }
}