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

class _ArticleViewState extends State<ArticleView> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  void _launchURL() async {
    Uri uri = Uri.parse(widget.model.url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch ${widget.model.url}';
    }
  }
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
      body: AnimatedBuilder(
        animation: _animation,
        builder: (context,child) {
          return Opacity(
            opacity: _animation.value,
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.network(widget.model.urlToImage, fit: BoxFit.cover),
                    Text(
                      widget.model.title,
                      style:
                      const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.w600),
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
                    GestureDetector(
                      onTap:  () {
              widget.model.isLiked ^= true;
              setState(() {});
              },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        padding: EdgeInsets.all(widget.model.isLiked ? 8.0 : 4.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: widget.model.isLiked ? Colors.white : null,
                        ),
                        child: Icon(
                          widget.model.isLiked
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: widget.model.isLiked ? Colors.red : null,
                        ),
                      ),
                    ),

                  ],
                  // height: MediaQuery.of(context).size.height,
                  // width: MediaQuery.of(context).size.width
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
