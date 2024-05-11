import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/article_model.dart';
import 'package:flutter_application_1/services/FavoritesService.dart';
import 'package:flutter_application_1/services/NewsService.dart';
import 'package:get/get.dart';

class NewsController extends GetxController {
  var articles = <Article>[].obs;
  var filteredArticles = <Article>[].obs;
  var favorites = <Article>[].obs;
  var isLoading = true.obs;
  TextEditingController searchController = TextEditingController();
  late final NewsService newsService;

  @override
  void onInit() async {
    super.onInit();
    newsService = NewsService();
    await fetchFavorites();
    await getNews('bbc-news');
  }

  void filterArticles(String query) {
    var filtered = articles.where((article) {
      return article.title!.toLowerCase().contains(query.toLowerCase());
    }).toList();
    filteredArticles.assignAll(filtered);
  }

  Future<void> refreshNews() async {
    try {
      getNews('bbc-news');
    } catch (e) {
      print("Error refreshing news: $e");
    }
  }

  Future<void> getNews(String channel) async {
    isLoading.value = true;
    try {
      articles.value = await newsService.fetchArticles();
      articles.removeWhere((element) =>
          element.urlToImage == null || element.description == null);

      filterArticles(searchController.text);
    } catch (e) {
      print("Error getting news: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchFavorites() async {
    favorites.value = await FavoritesService.instance.fetchFavorites();
    print(favorites);
  }

  Future<void> addFavorites(Article article) async {
    favorites.add(article);
    await FavoritesService.instance.addFavorites(article);
  }

  Future<void> removeFavorites(Article article) async {
    favorites.remove(article);
    await FavoritesService.instance.removeFavorites(article);
  }
}
