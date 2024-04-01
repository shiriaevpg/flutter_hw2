import 'package:flutter/material.dart';
import 'package:homework_1/models/ArticleModel.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/NewsModel.dart';

class ArticleView extends StatefulWidget {
  late ArticleModel model;
  ArticleView({super.key, required this.model});

  @override
  State<ArticleView> createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  void _launchURL() async {
    Uri uri = Uri.parse(widget.model.url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch ${widget.model.url}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Flutter",
              style:
                  TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
            ),
            Text(
              "News",
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.network(widget.model.urlToImage, fit: BoxFit.cover),
              Text(
                widget.model.title,
                style:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
              ),
              Text(widget.model.content),
              InkWell(
                onTap: _launchURL,
                child: Text(
                  widget.model.url,
                  style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 16.0,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              IconButton(
                  onPressed: () {
                    widget.model.isLiked ^= true;
                    setState(() {});
                  },
                  icon: widget.model.isLiked
                      ? const Icon(Icons.favorite)
                      : const Icon(Icons.favorite_border_outlined)),
            ],
            // height: MediaQuery.of(context).size.height,
            // width: MediaQuery.of(context).size.width
          ),
        ),
      ),
    );
  }
}
