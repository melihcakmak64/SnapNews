import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/newsController.dart';
import 'package:flutter_application_1/view/widgets/blogTileWidget.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class NewsScreen extends StatelessWidget {
  final NewsController newsController = Get.put(NewsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SnapNews', style: TextStyle(fontSize: 30)),
        actions: [
          Obx(
            () => IconButton(
                onPressed: () {
                  newsController.changeSource();
                },
                icon: Image.asset(newsController.isGlobal.value
                    ? "images/earth.png"
                    : "images/turkey.png")),
          ),
        ],
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: newsController.refreshNews,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextField(
                  controller: newsController.searchController,
                  decoration: InputDecoration(
                    hintText: 'Check the latest news',
                    fillColor: Colors.grey[300],
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                  ),
                  onChanged: (value) {
                    newsController.filterArticles(value);
                  },
                ),
              ),
            ),
            Container(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: newsController.categoriesMap.values.length,
                itemBuilder: (context, index) {
                  String item =
                      newsController.categoriesMap.values.toList()[index];

                  return Obx(
                    () {
                      var selectedList = newsController.selectedCategories;
                      Color color = selectedList.contains(item)
                          ? Colors.red
                          : Colors.blue;
                      return TextButton(
                          onPressed: () {
                            if (selectedList.contains(item)) {
                              selectedList.remove(item);
                            } else {
                              selectedList.add(item);
                            }
                            newsController.filterArticlesByCategory();
                          },
                          child: Text(
                            item,
                            style: TextStyle(color: color),
                          ));
                    },
                  );
                },
              ),
            ),
            Expanded(
              child: Obx(() {
                if (newsController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                } else if (newsController.filteredArticles.isEmpty) {
                  return const Center(child: Text('No news available'));
                } else {
                  return ListView.builder(
                    itemCount: newsController.filteredArticles.length,
                    itemBuilder: (context, index) {
                      return BlogTile(
                        news1: newsController.filteredArticles[index],
                      );
                    },
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
