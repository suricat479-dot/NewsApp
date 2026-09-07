import '../entities/article.dart';

abstract class NewsRepository {
  Future<List<Article>> getTopHeadlines();
  Future<List<Article>> searchNews(
    String query, {
    int page = 1,
    int pageSize = 10,
  });
}