import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/news_provider.dart';
import '../widgets/news_card.dart';

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
    Future.microtask(() =>
        Provider.of<NewsProvider>(context, listen: false).fetchTopHeadlines());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NewsProvider>(context);
    final isQueryEmpty = _searchController.text.trim().isEmpty;
    final displayList = isQueryEmpty ? provider.articles : provider.searchResults;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Новости', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Поисковая строка
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                provider.search(value);
              },
              decoration: InputDecoration(
                hintText: 'Поиск новостей...',
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, color: Colors.grey),
                        onPressed: () {
                          _searchController.clear();
                          provider.search('');
                        },
                      )
                    : null,
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          
          // Контент
          Expanded(
            child: provider.isLoading || provider.isSearching
                ? const Center(child: CircularProgressIndicator())
                : provider.errorMessage != null
                    ? Center(child: Text(provider.errorMessage!))
                    : displayList.isEmpty
                        ? const Center(child: Text('Новости не найдены'))
                        : ListView.builder(
                            itemCount: displayList.length,
                            itemBuilder: (context, index) {
                              return NewsCard(article: displayList[index]);
                            },
                          ),
          ),
        ],
      ),
    );
  }
}