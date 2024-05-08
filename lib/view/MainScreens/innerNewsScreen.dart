import 'package:flutter/material.dart';
import 'package:flutter_application_1/newsProviders/categories_news_model.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsArticleScreen extends StatelessWidget {
  Articles news;

  NewsArticleScreen({
    Key? key,
    required this.news,
  }) : super(key: key);

  Future<void> _launchInBrowser(String url) async {
    final Uri uri = Uri(
      scheme: "https",
      path: url,
    );
    if (await canLaunchUrl(uri)) {
      bool launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
      if (!launched) {
        throw 'Could not launch $url';
      }
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _saveArticle() async {
    // Show a toast or a snackbar
    print("Article Saved!");
  }

  @override
  Widget build(BuildContext context) {
    List<String> parts = news.publishedAt!.split('T');
    String date = parts[0];
    String time = parts[1].substring(0, 8);
    return Scaffold(
      appBar: AppBar(
        title: Text('News'),
        backgroundColor: Colors.grey,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              news.urlToImage!,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    date,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    time,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                news.title!,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Summary:",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey[800],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                news.description!,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[800],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                news.source?.name ?? '',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(25),
                  child: ElevatedButton(
                    onPressed: () => _saveArticle,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.grey[300],
                      textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: Text("Save the News"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(25),
                  child: ElevatedButton(
                    onPressed: () =>
                        print("iÇERİK ${news.content}"), // Launching the URL
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.grey[300],
                      textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: Text("View full article"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
