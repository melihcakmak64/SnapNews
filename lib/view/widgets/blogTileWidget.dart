import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/newsController.dart';
import 'package:flutter_application_1/models/article_model.dart';
import 'package:flutter_application_1/view/MainScreens/DetailPage.dart';
import 'package:flutter_application_1/view/widgets/toogleButton.dart';
import 'package:get/get.dart';

class BlogTile extends StatelessWidget {
  final Article news1;

  BlogTile({required this.news1});

  final NewsController newsController = Get.find();

  @override
  Widget build(BuildContext context) {
    bool isFavorite = newsController.favorites.contains(news1);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsScreen(
              news: news1,
              initialBookmarkStatus: newsController.favorites.contains(news1),
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
                imageUrl: news1.imageUrl ?? "",
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
                        news1.title!,
                        style: Theme.of(context).textTheme.headline6,
                        maxLines:
                            null, // Allow the text to wrap onto multiple lines
                      ),
                    ),
                    SizedBox(width: 8.0),
                    Obx(
                      () {
                        var favorites = newsController.favorites;
                        bool isFavorite = favorites.contains(news1);

                        return ToogleButton(
                          isBookmarked: isFavorite,
                          onTap: () async {
                            if (isFavorite == false) {
                              await newsController.addFavorites(news1);
                            } else {
                              await newsController.removeFavorites(news1);
                            }
                          },
                        );
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
