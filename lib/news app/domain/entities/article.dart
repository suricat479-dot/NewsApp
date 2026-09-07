class Article {
  final String title;
  final String? description;
  final String? urlToImage;
  final String? author;
  final String? publishedAt;
  final String? content;

  Article({
    required this.title,
    this.description,
    this.urlToImage,
    this.author,
    this.publishedAt,
    this.content,
  });
}