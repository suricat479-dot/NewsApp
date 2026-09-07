import 'package:injectable/injectable.dart';
import '../../domain/entities/article.dart';
import '../../domain/repositories/news_repository.dart';
import 'package:news_app/news app/data/data_source/remote/news_data_source_impl.dart';

@LazySingleton(as: NewsRepository)
class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource remoteDataSource;

  NewsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Article>> getTopHeadlines() async {
    return await remoteDataSource.getTopHeadlines();
  }
}