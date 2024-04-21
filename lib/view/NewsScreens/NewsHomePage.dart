import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/NewsScreens/AIChatPage.dart';
import 'package:flutter_application_1/view/NewsScreens/ProfilePage.dart';
import 'package:flutter_application_1/view/widgets/newsPreviewWidget.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 1) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ChatPage()));
      } // Navigate to the AIChat screen
      else if (_selectedIndex == 2) {
      } // Navigate to the Saved screen
      else if (_selectedIndex == 3) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ProfileScreen()));
      } // Navigate to the Profile screen
      else {
        // Stay at Home screen
      }
    });
  }

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
                      'resimler/download.jpg', // Replace with your image asset
                ),
                NewsPreviewWidget(
                  title: 'Breaking News Title',
                  content:
                      'Short preview of the breaking news article content...',
                  imageUrl:
                      'resimler/download.jpg', // Replace with your image asset
                ),
                NewsPreviewWidget(
                  title: 'Featured Article Title',
                  content: 'Short preview of the featured article content...',
                  imageUrl:
                      'resimler/download.jpg', // Replace with your image asset
                ),
                // Add more NewsPreview widgets as needed
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.psychology), // Change with the exact icon
            label: 'AIChat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Saved',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey[600],
        onTap: _onItemTapped,
      ),
    );
  }
}
