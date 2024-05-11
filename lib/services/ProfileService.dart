import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/models/user_model.dart';

class ProfileService {
  ProfileService._();
  final userCollection = FirebaseFirestore.instance.collection("users");
  final firebaseAuth = FirebaseAuth.instance;

  static final ProfileService instance = ProfileService._();

  Future<UserModel> fetchUser() async {
    final currentUser = firebaseAuth.currentUser;
    if (currentUser == null) {
      throw Exception('No user signed in');
    }

    final userData = await userCollection.doc(currentUser.uid).get();
    if (!userData.exists) {
      throw Exception('User data not found');
    }

    return UserModel.fromJson(userData.data()!);
  }

  Future<void> updateUser(UserModel newUser) async {
    final currentUser = firebaseAuth.currentUser;
    if (currentUser == null) {
      throw Exception('No user signed in');
    }

    final userData = await userCollection.doc(currentUser.uid).get();
    if (!userData.exists) {
      throw Exception('User data not found');
    }

    // Update user data with the new user model
    await userCollection.doc(currentUser.uid).update(newUser.toJson());
  }
}
