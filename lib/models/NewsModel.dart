import 'dart:convert';

import 'package:homework_1/models/ArticleModel.dart';
import 'package:homework_1/secret.dart';
import 'package:http/http.dart' as http;

class News {
  List<ArticleModel> news = [];
  final String baseUrl =
      "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=";
  Future<void> getNews() async {
    String url = baseUrl + ApiKey;

    var response = await http.get(Uri.parse(url));
    var data = jsonDecode(response.body);
    if (data['status'] == 'ok') {
      data['articles'].forEach((elem) {
        if (elem['urlToImage'] != null && elem['description'] != null) {
          ArticleModel article = ArticleModel(
              author: elem['author'],
              title: elem['title'],
              description: elem['description'],
              url: elem['url'],
              urlToImage: elem['urlToImage'],
              content: elem['content'],
              isLiked: false);
          news.add(article);
        }
      });
    }
  }
}
