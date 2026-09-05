import '../../domain/entities/article.dart';

class ArticleModel extends Article {
  ArticleModel({
    required String title,
    String? description,
    String? urlToImage,
    String? publishedAt,
    String? author,
  }) : super(
          title: title,
          description: description,
          urlToImage: urlToImage,
          publishedAt: publishedAt,
          author: author,
        );

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      title: json['title'] ?? 'Без заголовка',
      description: json['description'],
      urlToImage: json['urlToImage'],
      publishedAt: json['publishedAt'],
      author: json['author'],
    );
  }
}