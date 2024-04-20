import 'package:flutter/material.dart';

// This is a widget for prints and use for selecting news type that we interested in.
class NewsTypeWidget extends StatelessWidget {
  // Add a final String parameter newsType
  final String newsType;

  // Require the parameter in the constructor
  const NewsTypeWidget({Key? key, required this.newsType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.grey[300], // Background color of the widget
        borderRadius: BorderRadius.circular(25), // Match the border radius
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            newsType, // newsType parameter for the text
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 35), // Space between text and button
          SizedBox(
            width: 40,
            height: 40,
            child: FloatingActionButton(
              onPressed: () {
                // Action when button is pressed
              },
              child: Icon(Icons.add),
              backgroundColor: Colors.white, // Button background color
              foregroundColor: Colors.black, // Icon color
              elevation: 0, // Remove shadow
            ),
          ),
        ],
      ),
    );
  }
}
