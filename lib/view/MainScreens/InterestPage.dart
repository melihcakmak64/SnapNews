import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/HomePage.dart';
import 'package:flutter_application_1/view/widgets/newsTypeWidget.dart';

class InterestsScreen extends StatefulWidget {
  final String previousPage; // Add a parameter to track the previous page

  InterestsScreen({required this.previousPage});

  @override
  _InterestsScreenState createState() => _InterestsScreenState();
}

class _InterestsScreenState extends State<InterestsScreen> {
  Map<String, String> selectedInterests = {};

  void toggleInterest(String key, String value) {
    setState(() {
      if (selectedInterests.containsKey(key)) {
        selectedInterests.remove(key);
      } else {
        selectedInterests[key] = value;
      }
    });
  }

  void navigateToNextScreen() {
    // Implement the navigation to next screen and pass the selectedInterests
    if (widget.previousPage == 'Profile') {
      Navigator.pop(context); // Navigate back to the Profile page
    } else if (widget.previousPage == 'Register') {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) =>
                  HomePage())); // Navigate to the main screen
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context);
    final double screenWidth = screenSize.size.width;
    final double screenHeight = screenSize.size.height;

    var categoriesMap = {
      '3-sayfa': 'Crime',
      'dunya': 'World',
      'yasam': 'Life',
      'egitim': 'Education',
      'ekonomi': 'Economy',
      'finans': 'Finance',
      'guncel': 'Latest',
      'politika': 'Political',
      'saglik': 'Health',
      'son-dakika': 'NewsBreak',
      'spor': 'Sport',
      'turizm': 'Tourism',
      'müzik': 'Music'
    };

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Specify your interests',
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              children: List.generate(categoriesMap.length, (index) {
                String key = categoriesMap.keys.elementAt(index);
                String value = categoriesMap[key]!;
                return TypeWidget(
                  newsType: value,
                  screenHeight: screenHeight,
                  screenWidth: screenWidth,
                  isSelected: selectedInterests.containsKey(key),
                  onTap: () => toggleInterest(key, value),
                );
              }),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              navigateToNextScreen();
            },
            child: Text(
              'Approve',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[500], // Background color
            ),
          ),
        ],
      ),
    );
  }
}
