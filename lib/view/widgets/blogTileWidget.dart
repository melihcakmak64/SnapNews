import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/newsProviders/article_model.dart';
import 'package:flutter_application_1/view/MainScreens/innerNewsScreen.dart';
import 'package:flutter_application_1/view/widgets/savedButton.dart';

class BlogTile extends StatefulWidget {
  final Article news1;

  BlogTile({required this.news1});

  @override
  _BlogTileState createState() => _BlogTileState();
}

class _BlogTileState extends State<BlogTile> {
  bool isBookmarked = false;

  void _updateBookmarkStatus(bool status) {
    setState(() {
      isBookmarked = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsScreen(
              news: widget.news1,
              initialBookmarkStatus: isBookmarked,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Material(
          elevation: 3.0,
          borderRadius: BorderRadius.circular(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                imageUrl: widget.news1.urlToImage!,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        widget.news1.title!,
                        style: Theme.of(context).textTheme.headline6,
                        maxLines:
                            null, // Allow the text to wrap onto multiple lines
                      ),
                    ),
                    SizedBox(width: 8.0),
                    BookmarkToggleButton(
                      initialState: isBookmarked,
                      onToggle: (bool newBookmarkStatus) {
                        _updateBookmarkStatus(newBookmarkStatus);
                        print("Bookmark status updated: $newBookmarkStatus");
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
