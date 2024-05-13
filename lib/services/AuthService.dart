import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/user_model.dart';
import 'package:flutter_application_1/view/HomePage.dart';
import 'package:flutter_application_1/view/MainScreens/InterestPage.dart';
import 'package:flutter_application_1/view/MainScreens/NewsHomePage.dart';
import 'package:get/get.dart';

class AuthService {
  AuthService._();
  final userCollection = FirebaseFirestore.instance.collection("users");
  final firebaseAuth = FirebaseAuth.instance;
  late UserModel currentUser;

  static final AuthService instance = AuthService._();

  Future<void> signUp({
    required String username,
    required String email,
    required String password,
    required String country,
  }) async {
    try {
      final UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        await _registerUser(
            username: username,
            email: email,
            password: password,
            country: country,
            userId: userCredential.user!.uid);
        Get.offAll(InterestsScreen(previousPage: 'Register'));
        await getCurrentUserModel();
      }
    } on FirebaseAuthException catch (e) {
      // Fluttertoast.showToast(msg: e.message!, toastLength: Toast.LENGTH_LONG);
      Get.snackbar("There is an error", e.message!,
          backgroundColor: Colors.red);
    }
  }

  Future<void> signIn({required String email, required String password}) async {
    try {
      final UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        await getCurrentUserModel();

        Get.offAll(HomePage());
      }
    } on FirebaseAuthException catch (e) {
      // Fluttertoast.showToast(msg: e.message!, toastLength: Toast.LENGTH_LONG);
      Get.snackbar("There is an error", e.message!,
          backgroundColor: Colors.red);
    }
  }

  Future<void> _registerUser({
    required String username,
    required String email,
    required String password,
    required String country,
    required String userId,
  }) async {
    await userCollection.doc(userId).set({
      "username": username,
      "email": email,
      "password": password,
      "country": country,
      "uid": userId,
    });
  }

  Future<void> signOut() async {
    return await firebaseAuth.signOut();
  }

  Future<void> getCurrentUserModel() async {
    final user = firebaseAuth.currentUser;
    if (user != null) {
      final userData = await userCollection.doc(user.uid).get();
      if (userData.exists) {
        currentUser =
            UserModel.fromJson(userData.data() as Map<String, dynamic>);
      }
    }
  }

  Future<void> changePassword(String newPassword) async {
    try {
      final user = firebaseAuth.currentUser;
      if (user != null) {
        await user.updatePassword(newPassword);
        // Şifre değiştirme başarılı olduğunda bir bildirim veya işlem yapılabilir.
        print("Şifre değiştirme başarılı!");
      } else {
        // Kullanıcı oturum açmamışsa hata mesajı gösterilebilir.
        throw FirebaseAuthException(
          code: "user-not-found",
          message: "Kullanıcı oturum açmamış.",
        );
      }
    } on FirebaseAuthException catch (e) {
      // Hata durumunda uygun işlemler yapılabilir.
      print("Şifre değiştirme hatası: ${e.message}");
      // Hata mesajını kullanıcıya göstermek için Get.snackbar gibi bir metod kullanılabilir.
      Get.snackbar("Şifre değiştirme hatası", e.message!,
          backgroundColor: Colors.red);
    }
  }
}
