import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/newsController.dart';
import 'package:flutter_application_1/models/article_model.dart';
import 'package:flutter_application_1/view/widgets/toogleButton.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class DetailsScreen extends StatefulWidget {
  final Article news;
  final bool initialBookmarkStatus;
  List<Map<String, String>> texts = [];

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
  bool isLoadingSummary = false;
  bool isExpanded = false;
  String summary = '';
  bool isTurkishSource = false;

  @override
  void initState() {
    super.initState();
    isBookmarked = widget.initialBookmarkStatus;
    print(widget.news.content);
    // Check if the content is null to determine if it's a Turkish source
    if (widget.news.content == null || widget.news.content!.isEmpty) {
      //Boş sözlük atanıyor onun yerine null değer atanmalı
      isTurkishSource = true;
    } else {
      // Populate texts directly from the news content
      widget.news.content!.forEach((key, value) {
        var newKey = key.contains("_") ? " " : key;
        widget.texts.add({newKey: value});
      });
    }
  }

  Future<void> fetchSummary() async {
    setState(() {
      isLoadingSummary = true;
    });
    String concatenated =
        widget.texts.map((map) => map.values.join(" ")).join(" ");
    print(concatenated);
    String summaryText = await searchContent("Summarize " + concatenated);
    setState(() {
      summary = summaryText;
      isLoadingSummary = false;
    });
  }

  Future<String> searchContent(String givenPrompt) async {
    if (givenPrompt.isNotEmpty) {
      final model = GenerativeModel(
        model: 'gemini-pro',
        apiKey: "AIzaSyAQy7pghDRagRCMCfSkIjVcjLy4idzShkc",
      );

      final prompt = givenPrompt;
      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);
      return response.text!;
    }
    return '';
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
              widget.news.imageUrl,
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
                widget.news.title,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ExpansionTile(
              title: Text(
                "Tap here to read the summary",
                style: TextStyle(color: Colors.grey[800], fontSize: 18),
              ),
              subtitle: Text(
                "Expand for more",
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
              initiallyExpanded: isExpanded,
              onExpansionChanged: (bool expanded) {
                setState(() {
                  isExpanded = expanded;
                  if (isExpanded && summary.isEmpty && !isLoadingSummary) {
                    fetchSummary();
                  }
                });
              },
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: isLoadingSummary
                      ? CircularProgressIndicator()
                      : Text(
                          summary,
                          style: TextStyle(fontSize: 16),
                        ),
                ),
              ],
            ),
            SizedBox(height: 10),
            isTurkishSource
                ? FutureBuilder<List<Map<String, String>>>(
                    future: newsController.fetchContent(widget.news.url),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        widget.texts = snapshot.data!;
                        print(widget.texts);
                        if (widget.texts != null && widget.texts.isNotEmpty) {
                          return ListView.builder(
                            shrinkWrap:
                                true, // Needed to nest ListView inside Column
                            physics:
                                NeverScrollableScrollPhysics(), // to disable ListView's own scrolling
                            itemCount: widget.texts.length,
                            itemBuilder: (context, index) {
                              Map<String, String> mapItem = widget.texts[index];
                              String key = mapItem.keys.first;
                              String value = mapItem.values.first;
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  key.isNotEmpty
                                      ? Padding(
                                          padding: const EdgeInsets.only(
                                              left: 6, top: 15),
                                          child: Text(
                                            key,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                        )
                                      : Container(),
                                  SizedBox(),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(left: 6, top: 25),
                                    child: Text(
                                      value,
                                      style: TextStyle(
                                        fontSize: 20,
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
                : widget.texts.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap:
                            true, // Needed to nest ListView inside Column
                        physics:
                            NeverScrollableScrollPhysics(), // to disable ListView's own scrolling
                        itemCount: widget.texts.length,
                        itemBuilder: (context, index) {
                          Map<String, String> mapItem = widget.texts[index];
                          String key = mapItem.keys.first;
                          String value = mapItem.values.first;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              key.isNotEmpty
                                  ? Padding(
                                      padding: const EdgeInsets.only(
                                          left: 6, top: 10),
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
                                padding:
                                    const EdgeInsets.only(left: 6, top: 10),
                                child: Text(
                                  value,
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      )
                    : Text("No articles found"),
          ],
        ),
      ),
    );
  }
}




/* import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/newsController.dart';
import 'package:flutter_application_1/models/article_model.dart';
import 'package:flutter_application_1/view/widgets/toogleButton.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class DetailsScreen extends StatefulWidget {
  final Article news;
  final bool initialBookmarkStatus;
  List<Map<String, String>> texts = [];

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
  bool isLoadingSummary = false;
  bool isExpanded = false;
  String summary = '';

  @override
  void initState() {
    super.initState();
    isBookmarked = widget.initialBookmarkStatus;
  }

  Future<void> fetchSummary() async {
    setState(() {
      isLoadingSummary = true;
    });
    String concatenated =
        widget.texts.map((map) => map.values.join(" ")).join(" ");
    print(concatenated);
    String summaryText = await searchContent("Summarize " + concatenated);
    setState(() {
      summary = summaryText;
      isLoadingSummary = false;
    });
  }

  Future<String> searchContent(String givenPrompt) async {
    if (givenPrompt.isNotEmpty) {
      final model = GenerativeModel(
        model: 'gemini-pro',
        apiKey: "AIzaSyAQy7pghDRagRCMCfSkIjVcjLy4idzShkc",
      );

      final prompt = givenPrompt;
      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);
      return response.text!;
    }
    return '';
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
            ExpansionTile(
              title: Text(
                "Tap here to read the summary",
                style: TextStyle(color: Colors.grey[800], fontSize: 18),
              ),
              subtitle: Text(
                "Expand for more",
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
              initiallyExpanded: isExpanded,
              onExpansionChanged: (bool expanded) {
                setState(() {
                  isExpanded = expanded;
                  if (isExpanded && summary.isEmpty && !isLoadingSummary) {
                    fetchSummary();
                  }
                });
              },
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: isLoadingSummary
                      ? CircularProgressIndicator()
                      : Text(
                          summary,
                          style: TextStyle(fontSize: 16),
                        ),
                ),
              ],
            ),
            SizedBox(height: 10),
            FutureBuilder(
              future: newsController.fetchContent(widget.news.url),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  widget.texts = snapshot.data!;
                  if (widget.texts != null && widget.texts.isNotEmpty) {
                    return ListView.builder(
                      shrinkWrap: true, // Needed to nest ListView inside Column
                      physics:
                          NeverScrollableScrollPhysics(), // to disable ListView's own scrolling
                      itemCount: widget.texts.length,
                      itemBuilder: (context, index) {
                        Map<String, String> mapItem = widget.texts[index];
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
                                      20, 
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
 */