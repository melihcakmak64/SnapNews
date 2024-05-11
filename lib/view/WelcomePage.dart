import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/view/AuthScreen/LoginPage.dart';
import 'package:flutter_application_1/view/OnboardingPage.dart';
import 'package:get/get.dart';

class WelcomePage extends StatefulWidget {
  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  late final PageController _pageController;
  int _activePage = 0;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  final List<OnboardingPage> pages = [
    const OnboardingPage(
      description: 'News according\nto your\nPreference and\nInterest',
      image: 'images/image1.png',
    ),
    const OnboardingPage(
      description: 'Read anytime\nanywhere',
      image: 'images/image2.png',
    ),
    const OnboardingPage(
      description: 'Find trending\n topics stay ahead \nand engaged',
      image: 'images/image3.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (value) {
              setState(() {
                _activePage = value;
              });
            },
            itemCount: pages.length,
            itemBuilder: (context, index) {
              return pages[index % pages.length];
            },
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                    pages.length,
                    (index) => Container(
                      height: 5,
                      width: 35,
                      color: _activePage == index ? Colors.black : Colors.white,
                      margin: const EdgeInsets.only(right: 10),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // TODO: Implement Continue button functionality
                    if (_activePage < pages.length - 1) {
                      // If not on the last page, move to the next page
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.ease,
                      );
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Continue",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff424242), // Arka plan rengi
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Get.offAll(() => LoginPage());
                  },
                  child: const Text(
                    "Skip",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
