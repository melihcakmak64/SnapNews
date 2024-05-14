import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/newsController.dart';
import 'package:flutter_application_1/models/article_model.dart';
import 'package:flutter_application_1/view/widgets/toogleButton.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;
import 'package:http/http.dart' as http;

class DetailsScreen extends StatefulWidget {
  final Article news;
  final bool initialBookmarkStatus;
  List<Map<String, String>> contentList = [];

  DetailsScreen({
    Key? key,
    required this.news,
    required this.initialBookmarkStatus,
  }) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late bool isBookmarked;
  NewsController newsController = Get.find();

  @override
  void initState() {
    super.initState();
    isBookmarked = widget.initialBookmarkStatus;
  }

  @override
  Widget build(BuildContext context) {
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
              widget.news.imageUrl!,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(child: SizedBox(width: 5)),
                  ToogleButton(
                    isBookmarked: isBookmarked,
                    onTap: () {
                      if (isBookmarked == false) {
                        newsController.favorites.add(widget.news);
                        print(newsController.favorites);
                      } else {
                        newsController.favorites.remove(widget.news);
                      }
                      setState(() {
                        isBookmarked = !isBookmarked;
                      });
                    },
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                widget.news.title!,
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
                widget.news.description!,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[800],
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Haberler.Com" ?? '',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              children: [
                Expanded(child: SizedBox(width: 5)),
                Padding(
                  padding: const EdgeInsets.all(25),
                  child: ElevatedButton(
                    onPressed: () {
                      print(widget.news.category);
                    }, // Implement summarization
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.grey[300],
                      textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: Text("Summarize"),
                  ),
                ),
              ],
            ),
            FutureBuilder(
              future: newsController.fetchContent(widget.news.url),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  final texts = snapshot.data;
                  if (texts != null && texts.isNotEmpty) {
                    return ListView.builder(
                      shrinkWrap: true, // Needed to nest ListView inside Column
                      physics:
                          NeverScrollableScrollPhysics(), // to disable ListView's own scrolling
                      itemCount: texts.length,
                      itemBuilder: (context, index) {
                        Map<String, String> mapItem = texts[index];
                        print(mapItem);
                        String key = mapItem.keys.first;
                        String value = mapItem.values.first;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            key.isNotEmpty
                                ? Padding(
                                    padding:
                                        const EdgeInsets.only(left: 6, top: 10),
                                    child: Text(
                                      key,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  )
                                : Container(),
                            Padding(
                              padding: const EdgeInsets.only(left: 6, top: 10),
                              child: Text(
                                value,
                                style: TextStyle(
                                  fontSize:
                                      20, // p elementlerinden gelen değerler için yazı tipi boyutunu burada ayarlayabilirsiniz
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    return Text("No articles found");
                  }
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
