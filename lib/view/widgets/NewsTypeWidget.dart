import 'package:flutter/material.dart';

// This is a widget for selecting news type that we are interested in.
class TypeWidget extends StatelessWidget {
  final String newsType;
  final bool isSelected;
  final double screenWidth;
  final double screenHeight;
  final VoidCallback onTap;

  const TypeWidget({
    Key? key,
    required this.newsType,
    required this.screenHeight,
    required this.screenWidth,
    this.isSelected = false,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(3),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.grey[200],
          borderRadius: BorderRadius.circular(22),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              newsType,
              style: TextStyle(
                fontSize: screenWidth / 28,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
            Icon(
              isSelected ? Icons.remove : Icons.add,
              size: screenWidth / 20,
              color: isSelected ? Colors.white : Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
