import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/widgets/newsPreviewWidget.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context);
    final double screenWidth = screenSize.size.width;
    final double screenHeight = screenSize.size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SnapNews',
          style: TextStyle(fontSize: 50),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Center(
            child: Container(
              width: screenWidth * 0.57, // Takes 80% of screen width
              margin: EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Check the latest news',
                  fillColor: Colors.grey,
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
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                NewsPreviewWidget(
                  title: 'Latest News Title',
                  content:
                      'Short preview of the latest news article content...',
                  imageUrl:
                      'images/download.jpg', // Replace with your image asset
                ),
                NewsPreviewWidget(
                  title: 'Breaking News Title',
                  content:
                      'Short preview of the breaking news article content...',
                  imageUrl: 'images/sport.jpg', // Replace with your image asset
                ),
                NewsPreviewWidget(
                  title: 'Featured Article Title',
                  content: 'Short preview of the featured article content...',
                  imageUrl:
                      'images/economy.jpg', // Replace with your image asset
                ),
                // Add more NewsPreview widgets as needed
              ],
            ),
          ),
        ],
      ),
    );
  }
}
