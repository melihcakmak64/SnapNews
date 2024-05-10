import 'package:flutter/material.dart';

class ToogleButton extends StatelessWidget {
  ToogleButton({required this.onTap, required this.isBookmarked, super.key});
  bool isBookmarked;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        transitionBuilder: (child, animation) {
          return ScaleTransition(scale: animation, child: child);
        },
        child: Icon(
          isBookmarked ? Icons.bookmark : Icons.bookmark_border,
          key: ValueKey<bool>(isBookmarked),
          size: 30, // Adjust as necessary
        ),
      ),
    );
  }
}
