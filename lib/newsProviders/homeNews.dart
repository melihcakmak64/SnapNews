import 'package:flutter/material.dart';
import 'package:flutter_application_1/newsProviders/news_channels_headlines_model.dart';
import 'package:flutter_application_1/newsProviders/news_repository.dart';

class NewsScreen2 extends StatefulWidget {
  @override
  _NewsScreen2State createState() => _NewsScreen2State();
}

class _NewsScreen2State extends State<NewsScreen2> {
  NewsChannelsHeadlinesModel? newsHeadlines;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    loadNews();
  }

  void loadNews() async {
    try {
      NewsRepository newsRepo = NewsRepository();
      var headlines = await newsRepo
          .fetchNewsChannelHealinesApi('bbc-news'); // Example channel
      setState(() {
        newsHeadlines = headlines;
        _loading = false;
      });
    } catch (e) {
      print('Failed to load news: $e');
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('News')),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: newsHeadlines?.articles!.length ?? 0,
              itemBuilder: (context, index) {
                var article = newsHeadlines!.articles![index];
                return ListTile(
                  title: Text(article.title!),
                  subtitle: Text(article.description!),
                );
              },
            ),
    );
  }
}
