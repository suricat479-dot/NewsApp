import 'package:injectable/injectable.dart';
import '../../domain/entities/article.dart';
import '../../domain/repositories/news_repository.dart';
import '../data_source/abstract/news_data_source.dart';

@LazySingleton(as: NewsRepository)
class NewsRepositoryImpl implements NewsRepository {
  final NewsDataSource newsDataSource;

  NewsRepositoryImpl({required this.newsDataSource});

  @override
  Future<List<Article>> getTopHeadlines() async {
    return await newsDataSource.getTopHeadlines();
  }

  @override
  Future<List<Article>> searchNews(String query) async {
    return await newsDataSource.searchNews(query);
  }
}