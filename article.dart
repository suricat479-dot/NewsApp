class Article {
  final String title;
  final String? description;
  final String? urlToImage;
  final String? publishedAt;
  final String? author;

  Article({
    required this.title,
    this.description,
    this.urlToImage,
    this.publishedAt,
    this.author,
  });
}