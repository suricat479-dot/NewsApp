import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:news_app/news_app/core/router/app_router.gr.dart';
import '../providers/news_provider.dart';
import '../widgets/news_card.dart';

@RoutePage()
class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NewsProvider>().loadMoreSearch();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Лента новостей'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              context.router.push(const ProfileRoute());
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Поиск новостей...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    context.read<NewsProvider>().loadMoreSearch();
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onSubmitted: (query) {
                if (query.isNotEmpty) {
                  context.read<NewsProvider>().search(query);
                }
              },
            ),
          ),
          Expanded(
            child: Consumer<NewsProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (provider.error != null) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Ошибка: ${provider.error}'),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: () => provider.loadMoreSearch(),
                          child: const Text('Повторить'),
                        ),
                      ],
                    ),
                  );
                }

                if (provider.articles.isEmpty) {
                  return const Center(child: Text('Новости не найдены'));
                }

                return RefreshIndicator(
                  onRefresh: () => provider.loadMoreSearch(),
                  child: ListView.builder(
                    itemCount: provider.articles.length,
                    itemBuilder: (context, index) {
                      final article = provider.articles[index];
                      return NewsCard(article: article);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}