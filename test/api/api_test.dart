import 'package:flutter_test/flutter_test.dart';
import 'package:homework_1/models/NewsModel.dart';

void main() {
  test("Basic API test", () async {
    News news = News();
    await news.getNews();
    final data = news.news;
    expect(data.isNotEmpty, true);
  });
}
