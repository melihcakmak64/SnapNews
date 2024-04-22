import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/widgets/newsPreviewWidget.dart';

class SavedNewsScreen extends StatefulWidget {
  const SavedNewsScreen({super.key});

  @override
  State<SavedNewsScreen> createState() => _SavedNewsScreenState();
}

class _SavedNewsScreenState extends State<SavedNewsScreen> {
  // Dummy data for the list of articles
  final List<Map<String, String>> articles = [
    {
      'title': 'Breaking News Title',
      'content': 'Here is some content for the breaking news...',
      'imageUrl':
          'images/download.jpg', // Replace with actual asset or network image
    },
    // Add more articles here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Saved News',
          style: TextStyle(fontSize: (MediaQuery.of(context).size.width) / 12),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey,
      ),
      backgroundColor: Colors.white, // Set the background color to white
      body: ListView.builder(
        itemCount: articles.length,
        itemBuilder: (BuildContext context, int index) {
          return NewsPreviewWidget(
            title: articles[index]['title']!,
            content: articles[index]['content']!,
            imageUrl: articles[index]['imageUrl']!,
          );
        },
      ),
    );
  }
}
