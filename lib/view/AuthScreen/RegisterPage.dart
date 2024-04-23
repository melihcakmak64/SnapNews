import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/registerController.dart';
import 'package:flutter_application_1/services/AuthService.dart';
import 'package:flutter_application_1/view/AuthScreen/LoginPage.dart';
import 'package:flutter_application_1/view/widgets/myButton.dart';
import 'package:flutter_application_1/view/widgets/myTextButton.dart';
import 'package:get/get.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});
  final RegisterController _registerController = Get.put(RegisterController());

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
              const Text("Create Account", style: TextStyle(fontSize: 32)),
              TextField(
                onChanged: (value) {
                  _registerController.email.value = value;
                },
                decoration: InputDecoration(
                  hintText: "Enter your email address",
                  label: Text("Enter your email address"),
                ),
              ),
              TextField(
                onChanged: (value) {
                  _registerController.username.value = value;
                },
                decoration: InputDecoration(
                    hintText: "Enter your username",
                    label: Text("Enter your username")),
              ),
              TextField(
                onChanged: (value) {
                  _registerController.password.value = value;
                },
                decoration: InputDecoration(
                    hintText: "Enter your password",
                    label: Text("Enter your Password")),
              ),
              TextField(
                onChanged: (value) {
                  _registerController.country.value = value;
                },
                decoration: InputDecoration(
                    hintText: "Country/Region", label: Text("Country/Region")),
              ),
              MyButton(
                buttonText: "REGISTER",
                buttonColor: Colors.grey,
                onTap: () async {
                  await _registerController.register();
                },
              ),
              GoogleAuthButton(
                onPressed: () {},
              ),
              FacebookAuthButton(
                onPressed: () {},
              ),
              MyTextButton(
                  buttonText: "You already have account? Login",
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
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
