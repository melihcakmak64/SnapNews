import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/MainScreens/AIChatPage.dart';
import 'package:flutter_application_1/view/MainScreens/NewsHomePage.dart';
import 'package:flutter_application_1/view/MainScreens/ProfilePage.dart';
import 'package:flutter_application_1/view/MainScreens/SavedNewsPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // Create a list of widgets to display the body for the corresponding tab.
  List<Widget> _pageOptions = [
    NewsScreen(),
    ChatPage(),
    SavedNewsScreen(),
    MainSettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageOptions[
          _selectedIndex], // This will change the body based on what tab is selected
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.psychology),
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
