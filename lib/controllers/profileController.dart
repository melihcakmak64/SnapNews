import 'dart:ffi';

import 'package:flutter_application_1/models/user_model.dart';
import 'package:flutter_application_1/services/ProfileService.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/profileScreens/accountTile.dart';
import 'package:flutter_application_1/profileScreens/editProfileScreen.dart';
import 'package:flutter_application_1/profileScreens/userProfileStless.dart';
import 'package:flutter_application_1/services/AuthService.dart';
import 'package:flutter_application_1/view/AuthScreen/LoginPage.dart';
import 'package:flutter_application_1/view/MainScreens/InterestPage.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  // Eğer gerekiyorsa, kullanıcı bilgilerini burada saklayabilirsiniz
  var name = ''.obs;
  var email = ''.obs;
  var imageUrl = ''.obs;
  var password = "".obs;
  var isEditing = false.obs;
  late final UserModel userModel;

  @override
  void onInit() async {
    // TODO: implement onInit
    userModel = await ProfileService.instance.fetchUser();
    name.value = userModel.username ?? "Error";
    email.value = userModel.email ?? "Error";
    imageUrl.value = userModel.profileURL ?? "Error";
    password.value = userModel.password ?? "Error";

    super.onInit();
  }

  void goToEditProfile() {
    Get.to(EditSettingsScreen());
  }

  void goToInterests() {
    Get.to(InterestsScreen());
  }

  void logOut() {
    AuthService.instance.signOut();
  }

  Future<void> updateProfile() async {
    userModel.email = email.value;
    if (userModel.password != password.value) {
      userModel.password = password.value;
      AuthService.instance.changePassword(password.value);
    }

    userModel.username = name.value;
    ProfileService.instance.updateUser(userModel);
  }
}
