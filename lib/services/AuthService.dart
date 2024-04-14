// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:xchange/models/UserModel.dart';
// import 'package:xchange/views/home/home_page.dart';

// class AuthService {
//   AuthService._();
//   final userCollection = FirebaseFirestore.instance.collection("users");
//   final firebaseAuth = FirebaseAuth.instance;
//   late UserModel currentUser;

//   static final AuthService instance = AuthService._();

//   Future<void> signUp(
//       {required String username,
//       required String name,
//       required String surname,
//       required String email,
//       required String password,
//       required country,
//       required bool isPrivate}) async {
//     try {
//       final UserCredential userCredential = await firebaseAuth
//           .createUserWithEmailAndPassword(email: email, password: password);
//       if (userCredential.user != null) {
//         await _registerUser(
//             username: username,
//             name: name,
//             email: email,
//             password: password,
//             surname: surname,
//             country: country,
//             userId: userCredential.user!.uid,
//             isPrivate: false);
//         Get.offAll(HomePage());
//         await getCurrentUserModel();
//       }
//     } on FirebaseAuthException catch (e) {
//       // Fluttertoast.showToast(msg: e.message!, toastLength: Toast.LENGTH_LONG);
//       Get.snackbar("There is an error", e.message!,
//           backgroundColor: Colors.red);
//     }
//   }

//   Future<void> signIn({required String email, required String password}) async {
//     try {
//       final UserCredential userCredential = await firebaseAuth
//           .signInWithEmailAndPassword(email: email, password: password);
//       if (userCredential.user != null) {
//         await getCurrentUserModel();

//         Get.offAll(HomePage());
//       }
//     } on FirebaseAuthException catch (e) {
//       // Fluttertoast.showToast(msg: e.message!, toastLength: Toast.LENGTH_LONG);
//       Get.snackbar("There is an error", e.message!,
//           backgroundColor: Colors.red);
//     }
//   }

//   Future<void> _registerUser(
//       {required String username,
//       required String name,
//       required String surname,
//       required String email,
//       required String password,
//       required String country,
//       required String userId,
//       required bool isPrivate}) async {
//     await userCollection.doc(userId).set({
//       "username": username,
//       "email": email,
//       "name": name,
//       "surname": surname,
//       "password": password,
//       "country": country,
//       "uid": userId,
//       "isPrivate": isPrivate
//     });
//   }

//   Future<void> signOut() async {
//     return await firebaseAuth.signOut();
//   }

//   Future<void> getCurrentUserModel() async {
//     final user = firebaseAuth.currentUser;
//     if (user != null) {
//       final userData = await userCollection.doc(user.uid).get();
//       if (userData.exists) {
//         currentUser =
//             UserModel.fromJson(userData.data() as Map<String, dynamic>);
//       }
//     }
//   }
// }
