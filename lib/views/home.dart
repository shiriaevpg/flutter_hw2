import 'package:flutter/material.dart';
import 'package:homework_1/models/ArticleModel.dart';
import 'package:homework_1/models/NewsModel.dart';
import 'package:homework_1/views/LikedView.dart';
import 'package:homework_1/views/article_view.dart';

import '../widgets/searchbar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<ArticleModel> articles = List<ArticleModel>.empty();
  bool _loading = true;

  Future<void> getNews() async {
    News news = News();
    await news.getNews();
    setState(() {
      articles = news.news;
      _loading = false;
      print(articles);
    });
  }

  @override
  void initState() {
    getNews();
  }

  @override
  Widget build(BuildContext buildContext) {
    return Scaffold(
        body: _loading
            ? Container(
                child: const CircularProgressIndicator(),
              )
            : CustomScrollView(
                slivers: [
                  SliverAppBar(
                    floating: true,
                    flexibleSpace: const FlexibleSpaceBar(
                      title: Row(
                        children: <Widget>[
                          Text("Flutter"),
                          Text(
                            "News",
                            style: TextStyle(color: Colors.blue),
                          )
                        ],
                      ),
                    ),
                    actions: [
                      IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          showSearch(
                            context: context,
                            delegate: SearchBarDelegate(articles),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.favorite),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LikedView(
                                      articles: articles
                                          .where((elem) => elem.isLiked)
                                          .toList())));
                        },
                      ),
                    ],
                  ),
                  SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) =>
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: ListView.builder(
                              itemCount: articles.length,
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return BlogTile(
                                  model: articles[index],
                                  callback: setState,
                                );
                              },
                            ),
                          )))
                ],
              ));
  }
}

class NewsCard extends StatelessWidget {
  final imageUrl, categoryName;
  const NewsCard({super.key, this.imageUrl, this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.network(
          imageUrl,
          width: 120,
          height: 60,
        ),
      ],
    );
  }
}

class BlogTile extends StatelessWidget {
  final ArticleModel model;
  final Function callback;
  const BlogTile({super.key, required this.model, required this.callback});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ArticleView(model: model)))
            .then((value) => callback(() {}));
      },
      // margin: EdgeInsets.only(bottom: 20),
      child: Column(
        children: <Widget>[
          ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(model.urlToImage)),
          Text(
            model.title,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Text(model.description)
        ],
      ),
    );
  }
}
