import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:news_app/news_app/core/router/app_router.gr.dart';
import '../../domain/entities/article.dart';

class NewsCard extends StatelessWidget {
  final Article article;

  const NewsCard({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: article.urlToImage != null
            ? Image.network(
                article.urlToImage!,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Icon(Icons.image_not_supported),
              )
            : const Icon(Icons.article, size: 40),
        title: Text(
          article.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          article.description ?? '',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        onTap: () {
          context.router.push(NewsDetailRoute(article: article));
        },
      ),
    );
  }
}