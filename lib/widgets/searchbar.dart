import 'package:flutter/material.dart';
import 'package:homework_1/models/ArticleModel.dart';
import 'package:homework_1/views/article_view.dart';

class SearchBarDelegate extends SearchDelegate<String> {
  final List<ArticleModel> news;

  SearchBarDelegate(this.news);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = news
        .where((article) =>
            article.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final article = results[index].title;
        return ListTile(
          title: Text(article),
          onTap: () {
            close(context, article);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = news
        .where((article) =>
            article.title.toLowerCase().contains(query.toLowerCase()))
        .toList()
        .map((elem) => elem.title)
        .toList();
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final suggestion = suggestions[index];
        return ListTile(
          title: Text(suggestion),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ArticleView(
                    model: news
                        .where((element) => element.title == suggestion)
                        .first),
              ),
            );
          },
        );
      },
    );
  }
}
