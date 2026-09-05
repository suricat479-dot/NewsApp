
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/news app/data/models/article_model.dart';

abstract class NewsRemoteDataSource {
  Future<List<ArticleModel>> getTopHeadlines();
}

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  final http.Client client;
  final String apiKey = '1f2e1381f5b34fbb9a9f460b80922ff0';

  NewsRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ArticleModel>> getTopHeadlines() async {
    final url = Uri.parse(
      'https://newsapi.org/v2/top-headlines?country=us&apiKey=$apiKey',
    );

    final response = await client.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List articlesJson = data['articles'] ?? [];
      return articlesJson.map((json) => ArticleModel.fromJson(json)).toList();
    } else {
      throw Exception('Ошибка загрузки новостей: ${response.statusCode}');
    }
  }
}