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
      // Örnek olarak 10 adet Article oluşturma işlemi
      List<Article> globalArticlesList = [];
      for (int i = 0; i < 5; i++) {
        // Burada Article'ın özelliklerini doldurmanız gerekecek.
        // Örnek olarak bir Article oluşturup globalArticles listesine ekleyebilirsiniz.
        Article article = Article(
          title: "I warmed up by stretching in a jail cell - Scheffler",
          url: "https://www.example.com/news/scheffler-jail-cell",
          imageUrl:
              "https://ichef.bbci.co.uk/news/2048/cpsprodpb/b7fc/live/beb41fa0-148b-11ef-9b12-1ba8f95c4917.jpg",
          description:
              "Scottie Scheffler was arrested before his second round at the US PGA Championship.",
          category: "Sports",
          content: {
            "Introduction":
                "Scottie Scheffler warmed up for his second round at the US PGA Championship by 'stretching in a jail cell' after being arrested on Friday morning.",
            "Incident Details":
                "The world number one was charged with second-degree assault of a police officer, third-degree criminal mischief, reckless driving and disregarding traffic signals from an officer following an incident outside Valhalla Golf Club.",
            "Scheffler's Statement":
                "My main focus after getting arrested was wondering if I could be able to come back out here and play, and fortunately I was able to do that,' he said. 'I was never angry, just in shock and I was shaking the whole time. It was definitely a new feeling for me.",
            "Police Interaction":
                "The officer that took me to the jail was very kind. He was great. We had a nice chat in the car, that kind of helped calm me down.",
            "Post-Release":
                "After his release, Scheffler arrived at Valhalla Golf Club 54 minutes before his tee-time and went on to post a five-under 66 to improve his overall score to nine under.",
            "Additional Statement":
                "He said his 'heart goes out to the family' of a man struck and killed by a shuttle bus near the club on Friday morning. That incident led to the traffic jam that Scheffler was trying to avoid in an effort to get to the golf club for his morning tee-time."
          },
        );
        globalArticlesList.add(article);
      }

      // Oluşturulan Article'ları globalArticles listesine atama
      globalArticles.assignAll(globalArticlesList);
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
