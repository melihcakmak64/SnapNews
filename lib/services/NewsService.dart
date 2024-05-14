import 'dart:convert';
import 'package:flutter_application_1/models/article_model.dart';
import 'package:http/http.dart' as http;

class NewsService {
  Future<List<Article>> fetchArticles() async {
    final String apiUrl =
        'https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=fdc847a945174558b58c08dcff436349';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['status'] == 'ok') {
          final List<dynamic> articlesJson = responseData['articles'];
          return articlesJson.map((json) => Article.fromJson(json)).toList();
        } else {
          throw Exception('Failed to load articles');
        }
      } else {
        throw Exception('Failed to load articles');
      }
    } catch (e) {
      throw Exception('Failed to load articles: $e');
    }
  }
}
