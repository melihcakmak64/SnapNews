import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/loginController.dart';
import 'package:flutter_application_1/view/AuthScreen/ForgatPasswordPage.dart';
import 'package:flutter_application_1/view/AuthScreen/RegisterPage.dart';
import 'package:flutter_application_1/view/HomePage.dart';
import 'package:flutter_application_1/view/MainScreens/NewsHomePage.dart';
import 'package:flutter_application_1/view/widgets/loginRow.dart';
import 'package:flutter_application_1/view/widgets/myButton.dart';
import 'package:flutter_application_1/view/widgets/myTextButton.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final LoginController _loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "SnapNews",
                style: TextStyle(fontSize: 48),
              ),
              const Text("Login", style: TextStyle(fontSize: 32)),
              TextField(
                onChanged: (value) {
                  _loginController.email.value = value;
                },
                decoration: const InputDecoration(
                    hintText: "Enter your email address or username",
                    label: Text("Enter your email address or username")),
              ),
              TextField(
                onChanged: (value) {
                  _loginController.password.value = value;
                },
                decoration: const InputDecoration(
                    hintText: "Enter your password",
                    label: Text("Enter your Password")),
              ),
              MyButton(
                buttonText: "LOGIN",
                buttonColor: Colors.grey,
                onTap: () async {
                  await _loginController.login();
                },
              ),
              MyTextButton(
                  buttonText: "Forgot password?",
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ResetPasswordPage()));
                  }),
              GoogleAuthButton(
                onPressed: () {},
              ),
              FacebookAuthButton(
                onPressed: () {},
              ),
              MyTextButton(
                  buttonText: "Don't have an account? Register",
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterPage()));
                  }),
              SizedBox(
                height: Get.size.height * 0.05,
              )
            ],
          ),
        ),
      ),
    );
  }
}
