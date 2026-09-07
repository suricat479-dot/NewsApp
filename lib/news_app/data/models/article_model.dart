import '../../domain/entities/article.dart';

class ArticleModel extends Article {
  ArticleModel({
    required String title,
    String? description,
    String? urlToImage,
    String? author,
    String? publishedAt,
    String? content,
  }) : super(
          title: title,
          description: description,
          urlToImage: urlToImage,
          author: author,
          publishedAt: publishedAt,
          content: content,
        );

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      title: json['title'] ?? '',
      description: json['description'],
      urlToImage: json['urlToImage'],
      author: json['author'],
      publishedAt: json['publishedAt'],
      content: json['content'],
    );
  }
}