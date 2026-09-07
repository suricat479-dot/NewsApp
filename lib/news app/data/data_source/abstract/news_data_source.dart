import 'package:news_app/news app/data/models/article_model.dart';

abstract class NewsDataSource {
  Future<List<ArticleModel>> getTopHeadlines();
  Future<List<ArticleModel>> searchNews(String query); // Новый метод
}