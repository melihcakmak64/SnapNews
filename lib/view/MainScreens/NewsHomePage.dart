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
  List<Article> filteredArticles = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getNews('bbc-news');
  }

  void filterArticles(String query) {
    List<Article> filtered = articles.where((article) {
      return article.title!.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      filteredArticles = filtered;
    });
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
        filteredArticles = articles;
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
              padding: const EdgeInsets.all(12.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: 'Check the latest news',
                    fillColor: Colors.grey[300],
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                  ),
                  onChanged: (value) {
                    filterArticles(value);
                  },
                ),
              ),
            ),
            Expanded(
              child: _loading
                  ? Center(child: CircularProgressIndicator())
                  : filteredArticles.isEmpty
                      ? Center(child: Text('No news available'))
                      : ListView.builder(
                          itemCount: filteredArticles.length,
                          itemBuilder: (context, index) {
                            return BlogTile(
                              news1: filteredArticles[index],
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
