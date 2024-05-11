import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/newsController.dart';
import 'package:flutter_application_1/view/widgets/blogTileWidget.dart';
import 'package:flutter_application_1/view/widgets/newsPreviewWidget.dart';
import 'package:get/get.dart';

class SavedNewsScreen extends StatelessWidget {
  SavedNewsScreen({super.key});

  NewsController newsController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Saved News',
          style: TextStyle(fontSize: (MediaQuery.of(context).size.width) / 12),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey,
      ),
      backgroundColor: Colors.white, // Set the background color to white
      body: Obx(
        () => ListView.builder(
          itemCount: newsController.favorites.length,
          itemBuilder: (BuildContext context, int index) {
            return BlogTile(news1: newsController.favorites[index]);
          },
        ),
      ),
    );
  }
}
