import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/article_model.dart';
import 'package:flutter_application_1/services/FavoritesService.dart';
import 'package:flutter_application_1/services/NewsService.dart';
import 'package:get/get.dart';

class NewsController extends GetxController {
  var articles = <Article>[].obs;
  var globalArticles = <Article>[].obs;
  var filteredArticles = <Article>[].obs;
  var favorites = <Article>[].obs;
  var isLoading = true.obs;
  var isGlobal = false.obs;
  TextEditingController searchController = TextEditingController();
  late final NewsService newsService;

  var selectedCategories = <String>[].obs; // Seçilen kategorilerin listesi

  var categoriesMap = {
    '3-sayfa': 'Crime',
    'dunya': 'World',
    'yasam': 'Life',
    'egitim': 'Education',
    'ekonomi': 'Economy',
    'finans': 'Finance',
    'guncel': 'Latest',
    'politika': 'Political',
    'saglik': 'Health',
    'son-dakika': 'NewsBreak',
    'spor': 'Sport',
    'turizm': 'Tourism',
    'müzik': 'Music'
  };

  @override
  void onInit() async {
    super.onInit();
    newsService = NewsService();
    await fetchFavorites();
    await getNews();
  }

  void filterArticles(String query) {
    if (isGlobal.value == false) {
      var filtered = articles.where((article) {
        return article.title!.toLowerCase().contains(query.toLowerCase());
      }).toList();
      filteredArticles.assignAll(filtered);
    } else {
      var filtered = globalArticles.where((article) {
        return article.title!.toLowerCase().contains(query.toLowerCase());
      }).toList();
      filteredArticles.assignAll(filtered);
    }
  }

  void filterArticlesByCategory() {
    filterArticles("");

    if (selectedCategories.isNotEmpty) {
      var filtered = filteredArticles
          .where(
              (p0) => selectedCategories.contains(categoriesMap[p0.category]))
          .toList();

      filteredArticles.assignAll(filtered);
    }
  }

  Future<void> refreshNews() async {
    try {
      getNews();
    } catch (e) {
      print("Error refreshing news: $e");
    }
  }

  Future<void> getNews() async {
    isLoading.value = true;
    try {
      articles.value =
          await newsService.fetchNewsArticles("https://www.haberler.com");
      articles.removeWhere((element) =>
          element.imageUrl == "No image URL" ||
          element.description == "No description");

      filterArticles(searchController.text);
      filterArticlesByCategory();
    } catch (e) {
      print("Error getting news: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getGlobalNews() async {
    isLoading.value = true;
    try {
      List<Article> articles = await newsService.fetchGlobalNews();

      // Oluşturulan Article'ları globalArticles listesine atama
      globalArticles.assignAll(articles);
      filterArticles(searchController.text);
    } catch (e) {
      print("Error getting global news: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> changeSource() async {
    isGlobal.value = !isGlobal.value;
    await getGlobalNews();
  }

  Future<List<Map<String, String>>> fetchContent(String url) async {
    final news = await newsService.fetchContent(url);
    return news;
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
