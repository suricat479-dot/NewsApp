import 'package:injectable/injectable.dart';
import '../entities/article.dart';
import '../repositories/news_repository.dart';

@injectable
class SearchNews {
  final NewsRepository repository;

  SearchNews(this.repository);

  Future<List<Article>> call(String query) async {
    if (query.trim().isEmpty) return [];
    return await repository.searchNews(query);
  }
}