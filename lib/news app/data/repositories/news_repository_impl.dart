import 'package:injectable/injectable.dart';
import '../../domain/entities/article.dart';
import '../../domain/repositories/news_repository.dart';
import '../data_source/abstract/news_data_source.dart';

@LazySingleton(as: NewsRepository)
class NewsRepositoryImpl implements NewsRepository {
  final NewsDataSource dataSource;

  NewsRepositoryImpl(this.dataSource);

  @override
  Future<List<Article>> getTopHeadlines() async {
    return await dataSource.getTopHeadlines();
  }

  @override
  Future<List<Article>> searchNews(String query) async {
    return await dataSource.searchNews(query);
  }
}