import '../../models/article_model.dart';

abstract class NewsDataSource {
  Future<List<ArticleModel>> getTopHeadlines();
  Future<List<ArticleModel>> searchNews(
    String query, {
    int page = 1,
    int pageSize = 10,
  });
}