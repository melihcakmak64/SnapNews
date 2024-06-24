import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
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
          .get(Uri.parse("https://www.haberler.com" + url), headers: {
        'User-Agent':
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, Gecko) Chrome/58.0.3029.110 Safari/537.36'
      });

      if (response.statusCode == 200) {
        dom.Document document = parser.parse(response.body);

        dom.Element? mainContainer =
            document.querySelector('div#icerikAlani.detay');
        if (mainContainer != null) {
          List<dom.Element> elements =
              mainContainer.querySelectorAll('h2, h3, p');
          String lastKey = '';
          List<Map<String, String>> texts = [];
          bool firstH2Processed = false;
          String firstH2Value = '';

          for (var element in elements) {
            if (element.localName == 'h2' && !firstH2Processed) {
              lastKey = element.text.trim().replaceAll(RegExp(r'\s+'), ' ');
              firstH2Processed = true;
            } else if ((element.localName == 'h2' ||
                    element.localName == 'h3') &&
                firstH2Processed) {
              lastKey = element.text.trim().replaceAll(RegExp(r'\s+'), ' ');
              texts.add({lastKey: ''});
            } else if (element.localName == 'p') {
              String trimmedText =
                  element.text.trim().replaceAll(RegExp(r'\s+'), ' ');
              if (trimmedText.isEmpty) {
                continue;
              }
              if (!firstH2Processed) {
                continue;
              }
              if (texts.isNotEmpty && texts.last.containsKey(lastKey)) {
                texts.last[lastKey] = texts.last[lastKey]! + trimmedText + '\n';
              } else {
                texts.add({lastKey: trimmedText});
              }
            }
          }

          if (firstH2Processed && firstH2Value.isNotEmpty) {
            texts.insert(0, {lastKey: firstH2Value});
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

  Future<void> addGlobalNews(Article article) async {
    CollectionReference articles =
        FirebaseFirestore.instance.collection('global_news');

    await articles.add(article.toJson());
  }

  Future<List<Map<String, String>>> fetchContentGlobal(String url) async {
    // Ensure the URL starts with "https://news.sky.com/"
    if (!url.startsWith('https://news.sky.com/')) {
      url = 'https://news.sky.com' + url;
    }

    var client = http.Client();
    try {
      final response = await client.get(Uri.parse(url), headers: {
        'User-Agent':
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, Gecko) Chrome/58.0.3029.110 Safari/537.36'
      });

      if (response.statusCode == 200) {
        dom.Document document = parser.parse(response.body);

        dom.Element? mainContainer = document.querySelector(
            'div.sdc-article-body.sdc-article-body--story.sdc-article-body--lead');
        if (mainContainer != null) {
          List<dom.Element> elements = mainContainer.querySelectorAll('p');
          List<Map<String, String>> texts = [];

          for (var element in elements) {
            // Skip paragraphs with specific classes
            if (element.classes.contains('sdc-article-strapline__text') ||
                element.classes.contains('ui-app-promo-cta') ||
                element.classes.contains('ui-app-promo-headline') ||
                element.querySelector('strong') != null) {
              continue;
            }

            String trimmedText =
                element.text.trim().replaceAll(RegExp(r'\s+'), ' ');
            if (trimmedText.isNotEmpty) {
              texts.add({'': trimmedText});
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

  Future<List<Article>> fetchGlobalNews() async {
    final response = await http.get(Uri.parse('https://news.sky.com/'));
    if (response.statusCode == 200) {
      var document = parser.parse(response.body);
      var articleElements =
          document.querySelectorAll('.grid-areas .grid-cell article');

      return articleElements
          .map((element) => Article.fromGlobal(element))
          .toList();
    } else {
      throw Exception('Failed to load articles');
    }
  }

  /* Future<List<Article>> fetchGlobalNews() async {
    CollectionReference articles =
        FirebaseFirestore.instance.collection('global_news');

    QuerySnapshot querySnapshot = await articles.get();
    List<QueryDocumentSnapshot> docs = querySnapshot.docs;

    List<Article> articlesList = docs
        .map((doc) => Article.fromJson(doc.data() as Map<String, dynamic>))
        .toList();

    return articlesList;
  } */
}
