import 'package:flutter/material.dart';

class NewsPreviewWidget extends StatelessWidget {
  final String title;
  final String content;
  final String imageUrl;

  const NewsPreviewWidget({
    Key? key,
    required this.title,
    required this.content,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Add this line
        crossAxisAlignment:
            CrossAxisAlignment.stretch, // Stretch to the edges of the container
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12.0)),
            child: Image.network(
              imageUrl,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              content,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // Handle button press
              },
              child: Text('View full article'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[700], // Background color
                foregroundColor: Colors.white, // Foreground (text) color
              ),
            ),
          ),
        ],
      ),
    );
  }
}
