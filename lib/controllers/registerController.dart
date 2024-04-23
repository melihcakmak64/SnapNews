import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/AuthService.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final email = ''.obs;
  final username = ''.obs;
  final password = ''.obs;
  final country = ''.obs;

  Future<void> register() async {
    if (email.value.isEmpty ||
        !GetUtils.isEmail(email.value) ||
        username.value.isEmpty ||
        password.value.isEmpty ||
        country.value.isEmpty) {
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
      await AuthService.instance.signUp(
        username: username.value,
        country: country.value,
        email: email.value,
        password: password.value,
      );
    }
  }
}
