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
            title:
                "Cannes Film Festival workers call for strike for better pay and conditions",
            url:
                "https://www.trtworld.com/magazine/was-eurovision-2024-the-most-politicised-eurovision-ever-18162930",
            imageUrl:
                "https://cdn-i.pr.trt.com.tr/trtworld/w424/h240/q80/19800736_2-0-1244-700.jpeg",
            description:
                "Members of a collective called Sous les Ecrans la Deche ('Poverty Behind the Screens') say they don't intend to cause significant disruption but want their demands heard.",
            category: "sanat",
            content: {
              "_1":
                  "Workers at the Cannes Film Festival have called for a strike over pay and conditions, just a week before the event was due to start.",
              "_2":
                  "Members of a collective called Sous les Ecrans la Deche ('Poverty Behind the Screens') said on Monday that they did not intend to cause significant disruption but wanted to draw attention to long-running demands.",
              "_3":
                  "'The strike will not put the opening of the festival at risk but there could be disruptions as it goes on,' a spokesperson told AFP.",
              "_4":
                  "The group said it represented around 100 workers, including projectionists, programmers, press agents and ticket sellers.",
              "_5":
                  "They work on short-term contracts but do not fall under France's unemployment insurance scheme for freelance artists and technicians in the cultural sector, which tops up salaries to a minimum wage.",
              "_6":
                  "'Most of us will have to give up working, which will jeopardise the events,' the group said in a statement.",
              "_7":
                  "'The forthcoming opening of the Cannes Film Festival has a bitter taste for us this year,' it added.",
              "_8":
                  "The festival organisers did not immediately respond to a request for comment.",
              "_9":
                  "The event on the French Cote d'Azur is considered the most prestigious for the world's film industry, attracting some 40,000 people each year.",
              "_10":
                  "This year's festival is due to run from May 14 to 25, with icons including Francis Ford Coppola, Georges Lucas and Meryl Streep set to attend."
            });
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
