import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/models/article_model.dart';

class FavoritesService {
  FavoritesService._();
  final userCollection = FirebaseFirestore.instance.collection("users");
  final firebaseAuth = FirebaseAuth.instance;

  static final FavoritesService instance = FavoritesService._();

  Future<List<Article>> fetchFavorites() async {
    final currentUser = firebaseAuth.currentUser;
    if (currentUser == null) {
      throw Exception('No user signed in');
    }

    final userData = await userCollection.doc(currentUser.uid).get();
    final favoritesData = userData.data()?['favorites'] ?? [];
    final favorites = List<Map<String, dynamic>>.from(favoritesData);

    final favoritesArticles = <Article>[];
    for (final favoriteJson in favorites) {
      final favoriteArticle = Article.fromJson(favoriteJson);
      favoritesArticles.add(favoriteArticle);
    }

    return favoritesArticles;
  }

  Future<void> addFavorites(Article article) async {
    final currentUser = firebaseAuth.currentUser;
    if (currentUser == null) {
      throw Exception('No user signed in');
    }

    final userData = await userCollection.doc(currentUser.uid).get();
    final favorites =
        List<Map<String, dynamic>>.from(userData.data()?['favorites'] ?? []);

    // Convert article to JSON
    final articleJson = article.toJson();

    // Add the article JSON to favorites list
    favorites.add(articleJson);

    // Update user's favorites list in Firestore
    await userCollection.doc(currentUser.uid).update({'favorites': favorites});
  }

  Future<void> removeFavorites(Article article) async {
    final currentUser = firebaseAuth.currentUser;
    if (currentUser == null) {
      throw Exception('No user signed in');
    }

    final userData = await userCollection.doc(currentUser.uid).get();
    final favorites =
        List<Map<String, dynamic>>.from(userData.data()?['favorites'] ?? []);

    // Find and remove the article from favorites list
    favorites
        .removeWhere((favoriteJson) => favoriteJson['title'] == article.title);

    // Update user's favorites list in Firestore
    await userCollection.doc(currentUser.uid).update({'favorites': favorites});
  }
}
