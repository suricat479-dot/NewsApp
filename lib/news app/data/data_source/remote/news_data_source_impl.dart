import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../abstract/news_data_source.dart';
import '../../models/article_model.dart';

@LazySingleton(as: NewsDataSource)
class NewsDataSourceImpl implements NewsDataSource {
  final Dio dio;

  NewsDataSourceImpl(this.dio);

  @override
  Future<List<ArticleModel>> getTopHeadlines() async {
    final response = await dio.get('/top-headlines', queryParameters: {'country': 'us'});
    final List articlesJson = response.data['articles'] ?? [];
    return articlesJson.map((json) => ArticleModel.fromJson(json)).toList();
  }

  @override
  Future<List<ArticleModel>> searchNews(String query) async {
    final response = await dio.get('/everything', queryParameters: {'q': query});
    final List articlesJson = response.data['articles'] ?? [];
    return articlesJson.map((json) => ArticleModel.fromJson(json)).toList();
  }
}