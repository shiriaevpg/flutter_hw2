import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/ArticleModel.dart';
import 'home.dart';

class LikedView extends StatefulWidget {
  List<ArticleModel> articles;
  LikedView({Key? key, required this.articles}) : super(key: key);

  @override
  State<LikedView> createState() => _LikedViewState();
}

class _LikedViewState extends State<LikedView> {
  @override
  Widget build(BuildContext context) {
    widget.articles =
        widget.articles.where((element) => element.isLiked).toList();
    return Scaffold(
      appBar: AppBar(
          title: const Row(
        children: <Widget>[
          Text("Flutter"),
          Text(
            "News",
            style: TextStyle(color: Colors.blue),
          )
        ],
      )),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView.builder(
          itemCount: widget.articles.length,
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemBuilder: (context, index) {
            return BlogTile(
              model: widget.articles[index],
              callback: setState,
            );
          },
        ),
      ),
    );
  }
}
