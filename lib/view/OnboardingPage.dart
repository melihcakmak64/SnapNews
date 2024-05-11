import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class OnboardingPage extends StatelessWidget {
  final String description;
  final String image;

  const OnboardingPage({
    Key? key,
    required this.description,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage(image),
        fit: BoxFit.cover,
      )),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(50),
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 40, color: Colors.white),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
