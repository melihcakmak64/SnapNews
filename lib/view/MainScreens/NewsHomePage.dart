import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/newsController.dart';
import 'package:flutter_application_1/view/widgets/blogTileWidget.dart';
import 'package:get/get.dart';

class NewsScreen extends StatelessWidget {
  final NewsController newsController = Get.put(NewsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SnapNews', style: TextStyle(fontSize: 30)),
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
