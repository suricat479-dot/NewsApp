import 'package:injectable/injectable.dart';
import '../entities/article.dart';
import '../repositories/news_repository.dart';

@injectable
class SearchNews {
  final NewsRepository repository;

  SearchNews(this.repository);

  Future<List<Article>> call(
    String query, {
    int page = 1,
    int pageSize = 10,
  }) async {
    if (query.trim().isEmpty) return [];
    return await repository.searchNews(query, page: page, pageSize: pageSize);
  }
}