class ArticleModel {
  late String author, title, description, url, urlToImage, content;
  bool isLiked;

  ArticleModel(
      {required this.author,
      required this.title,
      required this.description,
      required this.url,
      required this.urlToImage,
      required this.content,
      required this.isLiked});
}
