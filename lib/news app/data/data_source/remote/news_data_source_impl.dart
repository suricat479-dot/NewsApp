// lib/news app/data/data_source/remote/news_data_source_impl.dart

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../abstract/news_data_source.dart';
import '../../models/article_model.dart';

@LazySingleton(as: NewsDataSource)
class NewsRemoteDataSourceImpl implements NewsDataSource {
  final Dio dio;

  NewsRemoteDataSourceImpl(this.dio);

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