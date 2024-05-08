import 'package:flutter/material.dart';
import 'package:flutter_application_1/newsProviders/article_model.dart';
import 'package:flutter_application_1/newsProviders/news_channels_headlines_model.dart';
import 'package:flutter_application_1/newsProviders/news_repository.dart';
import 'package:flutter_application_1/view/widgets/blogTileWidget.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  List<Article> articles = [];
  bool _loading = true;
  int maxArticles = 10;

  @override
  void initState() {
    super.initState();
    getNews('bbc-news');
  }

  Future<void> _refreshNews() async {
    try {
      // Assuming you want to refresh based on a specific category or update all
      getNews('bbc-news');
    } catch (e) {
      print("Error refreshing news: $e");
    }
  }

  void getNews(String channel) async {
    NewsRepository newsRepo = NewsRepository();
    try {
      NewsChannelsHeadlinesModel news =
          await newsRepo.fetchNewsChannelHealinesApi(channel);
      articles = (news.articles)!;
      setState(() {
        _loading = false;
      });
    } catch (e) {
      print("Error fetching news: $e");
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SnapNews', style: TextStyle(fontSize: 30)),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: _refreshNews,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Check the latest news',
                  fillColor: Colors.grey[300],
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                ),
              ),
            ),
            Expanded(
              child: _loading
                  ? Center(child: CircularProgressIndicator())
                  : articles.isEmpty
                      ? Center(child: Text('No news available'))
                      : ListView.builder(
                          itemCount: articles.length,
                          itemBuilder: (context, index) {
                            return BlogTile(
                              news1: articles[index],
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
