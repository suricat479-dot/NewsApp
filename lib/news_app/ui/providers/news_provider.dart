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
  bool _isMoreLoading = false;
  bool _hasMore = true;
  int _currentPage = 1;
  String _currentQuery = '';
  String? _errorMessage;

  List<Article> get articles => _articles;
  List<Article> get searchResults => _searchResults;
  bool get isLoading => _isLoading;
  bool get isSearching => _isSearching;
  bool get isMoreLoading => _isMoreLoading;
  bool get hasMore => _hasMore;
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
      _currentQuery = '';
      _currentPage = 1;
      _hasMore = true;
      notifyListeners();
      return;
    }

    _currentQuery = query;
    _currentPage = 1;
    _hasMore = true;
    _isSearching = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final results = await searchNewsUseCase(_currentQuery, page: _currentPage);
      _searchResults = results;
      if (results.length < 10) _hasMore = false;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isSearching = false;
      notifyListeners();
    }
  }

  Future<void> loadMoreSearch() async {
    if (_isMoreLoading || !_hasMore || _currentQuery.isEmpty) return;

    _isMoreLoading = true;
    notifyListeners();

    _currentPage++;
    try {
      final newArticles = await searchNewsUseCase(_currentQuery, page: _currentPage);
      if (newArticles.isEmpty || newArticles.length < 10) {
        _hasMore = false;
      }
      _searchResults.addAll(newArticles);
    } catch (e) {
      _hasMore = false;
    } finally {
      _isMoreLoading = false;
      notifyListeners();
    }
  }
}