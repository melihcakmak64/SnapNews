import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/newsProviders/categories_news_model.dart';
import 'package:flutter_application_1/newsProviders/news_channels_headlines_model.dart';
import 'package:flutter_application_1/newsProviders/news_repository.dart';
import 'package:flutter_application_1/view/MainScreens/innerNewsScreen.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  List<Articles> articles = [];
  List<ArticlesBy> articles2 = [];
  bool _loading = true;
  int maxArticles = 10;

  @override
  void initState() {
    super.initState();
    _refreshNews();
  }

  Future<void> _refreshNews() async {
    try {
      // Assuming you want to refresh based on a specific category or update all
      getNewsByCategory('general');
    } catch (e) {
      print("Error refreshing news: $e");
    }
  }

  void getNews(String channel) async {
    NewsRepository newsRepo = NewsRepository();
    try {
      NewsChannelsHeadlinesModel news =
          await newsRepo.fetchNewsChannelHealinesApi(channel);
      articles2 = (news.articles)!;
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

  void getNewsByCategory(String category) async {
    setState(() {
      _loading = true; // Show loading indicator
    });
    try {
      CategoriesNewsModel news =
          await NewsRepository().fetchCategoriesNewsApi(category);
      setState(() {
        articles = news.articles!;
        _loading = false; // Hide loading indicator and show new data
      });
    } catch (e) {
      setState(() {
        _loading = false; // Hide loading indicator even if there's an error
        print("Error fetching news by category $category: $e");
      });
    }
  }

  /* void getNewsByCategory(String category) async { //Haberleri kategori ile çekme fonksiyonu
    NewsRepository newsRepo = NewsRepository();
    try {
      CategoriesNewsModel news =
          await newsRepo.fetchCategoriesNewsApi(category);
      articles = (news.articles)!;
      setState(() {
        _loading = false;
      });
    } catch (e) {
      print("Error fetching news by category $category: $e");
      setState(() {
        _loading = false;
      });
    }
  }
 */
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
                          itemCount: articles.length > maxArticles
                              ? maxArticles
                              : articles.length,
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
  /* Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SnapNews',
          style: TextStyle(fontSize: 30),
        ),
        centerTitle: true,
      ),
      body: Column(
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
                        itemCount: articles.length > maxArticles
                            ? maxArticles
                            : articles.length,
                        itemBuilder: (context, index) {
                          return BlogTile(
                            news1: articles[index],
                          );
                        },
                      ),
          ),
        ],
      ),
    ); 
  }*/
}

class BlogTile extends StatelessWidget {
  Articles news1;

  BlogTile({
    required this.news1,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => NewsArticleScreen(
                    news: news1,
                  )),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Material(
          elevation: 3.0,
          borderRadius: BorderRadius.circular(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                imageUrl: news1.urlToImage!,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(news1.title!,
                        style: Theme.of(context).textTheme.headline6),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
