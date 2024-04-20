import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/widgets/newsTypeWidget.dart';

class InterestsScreen extends StatefulWidget {
  @override
  _InterestsScreenState createState() => _InterestsScreenState();
}

class _InterestsScreenState extends State<InterestsScreen> {
  List<String> selectedInterests = [];

  void toggleInterest(String interest) {
    setState(() {
      if (selectedInterests.contains(interest)) {
        selectedInterests.remove(interest);
      } else {
        selectedInterests.add(interest);
      }
    });
  }

  void navigateToNextScreen() {
    // Implement the navigation to next screen and pass the selectedInterests
    print(selectedInterests); // Just for demonstration
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context);
    final double screenWidth = screenSize.size.width;
    final double screenHeight = screenSize.size.height;

    List<String> interests = [
      'Music',
      'Sport',
      'Travel',
      'Nature',
      'Finance',
      'Political',
      'Crime',
      'Economy',
      'Education',
      'Technology',
      'Game',
      'Top News',
      'Health',
      'Cinema',
      'Art',
      'Television',
      'Series',
      'Magazine',
      'Science'
    ];

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
              children: List.generate(interests.length, (index) {
                return TypeWidget(
                  newsType: interests[index],
                  screenHeight: screenHeight,
                  screenWidth: screenWidth,
                  isSelected: selectedInterests.contains(interests[index]),
                  onTap: () => toggleInterest(interests[index]),
                );
              }),
            ),
          ),
          ElevatedButton(
            onPressed: navigateToNextScreen,
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
