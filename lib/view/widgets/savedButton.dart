import 'package:flutter/material.dart';

class BookmarkToggleButton extends StatefulWidget {
  final bool initialState;
  final ValueChanged<bool> onToggle;

  BookmarkToggleButton({
    required this.initialState,
    required this.onToggle,
  });

  @override
  _BookmarkToggleButtonState createState() =>
      _BookmarkToggleButtonState(initialState);
}

class _BookmarkToggleButtonState extends State<BookmarkToggleButton> {
  bool isBookmarked;

  _BookmarkToggleButtonState(this.isBookmarked);

  void _toggleBookmark() {
    setState(() {
      isBookmarked = !isBookmarked;
    });
    widget.onToggle(isBookmarked);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _toggleBookmark,
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
