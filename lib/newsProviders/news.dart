import 'dart:convert';
import 'package:flutter_application_1/newsProviders/article_model.dart';
import 'package:http/http.dart' as http;

class News {
  List<Article> news = [];

  Future<void> getNews() async {
    String url =
        "https://newsapi.org/v2/everything?q=apple&from=2024-04-26&to=2024-04-26&sortBy=popularity&apiKey=fdc847a945174558b58c08dcff436349";
    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);
    if (jsonData["status"] == "ok") {
      jsonData["articles"].foreach((element) {
        if (element["urlToImage"] != null && element["description"] != null) {
          Article article = Article(
              title: element["title"],
              description: element["description"],
              url: element["url"],
              urlToImage: element["urlToImage"],
              content: element["content"],
              author: element["author"]);
          news.add(article);
        }
      });
    }
  }
}
