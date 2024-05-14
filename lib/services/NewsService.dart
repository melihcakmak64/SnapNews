import 'dart:convert';
import 'package:flutter_application_1/models/article_model.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;

class NewsService {
  Future<List<Article>> fetchNewsArticles(String url) async {
    var response = await http.get(
      Uri.parse(url),
      headers: {
        'Accept-Charset': 'UTF-8',
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );

    if (response.statusCode == 200) {
      var decodedBody = utf8.decode(latin1.encode(response.body));
      var document = parser.parse(decodedBody);
      List<dom.Element> articleElements =
          document.querySelectorAll('article.p12-col > a');
      List<Article> articles = articleElements
          .map((element) => Article.fromElement(element))
          .toList();
      return articles;
    } else {
      throw Exception('Failed to load news articles');
    }
  }

  Future<List<Map<String, String>>> fetchContent(String url) async {
    var client = http.Client();
    try {
      final response = await client
          .get(Uri.parse("https://www.haberler.com/" + url), headers: {
        'User-Agent':
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36'
      });

      if (response.statusCode == 200) {
        dom.Document document = parser.parse(response.body);
        dom.Element? mainContent =
            document.querySelector('main.hbptContent.haber_metni');
        if (mainContent != null) {
          List<dom.Element> elements = mainContent.querySelectorAll('h3, p');
          String lastKey = '';
          List<Map<String, String>> texts = [];

          for (var element in elements) {
            if (element.localName == 'h3') {
              lastKey = element.text.trim().replaceAll(RegExp(r'\s+'), ' ');
              texts.add({lastKey: ''});
            } else if (element.localName == 'p') {
              String trimmedText =
                  element.text.trim().replaceAll(RegExp(r'\s+'), ' ');
              if (trimmedText.isEmpty) {
                // Boş olan p elementlerini atla
                continue;
              }
              if (lastKey.isEmpty) {
                // İlk h3 bulunmadan önceki p elementlerini atla
                continue;
              } else {
                if (texts.isNotEmpty && texts.last.containsKey(lastKey)) {
                  texts.last[lastKey] =
                      texts.last[lastKey]! + trimmedText + '\n';
                } else {
                  texts.add({lastKey: trimmedText});
                }
              }
            }
          }
          return texts;
        }
      }
    } catch (e) {
      // Handle exceptions by logging or displaying a message
      print('Failed to fetch or process content: $e');
    } finally {
      client.close();
    }
    return [];
  }
}
