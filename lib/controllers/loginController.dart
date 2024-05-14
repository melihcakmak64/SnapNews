import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/AuthService.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final email = ''.obs;
  final password = ''.obs;

  Future<void> login() async {
    if (email.value.isEmpty ||
        !GetUtils.isEmail(email.value) ||
        password.value.isEmpty) {
      // Uygun olmayan değerler varsa Snackbar göster
      Get.snackbar(
        'Error',
        'Please fill all fields correctly.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else {
      // Kayıt işlemi başarılı ise AuthService'e işlemi gönder
      await AuthService.instance.signIn(
        email: email.value,
        password: password.value,
      );
      if (AuthService.instance.currentUser != null) {
        final currentUser = AuthService.instance.currentUser;
        currentUser.password = password.value;
        await AuthService.instance.updateUser(currentUser);
      }
    }
  }
}
