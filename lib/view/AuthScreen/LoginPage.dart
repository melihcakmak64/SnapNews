import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/widgets/loginRow.dart';
import 'package:flutter_application_1/view/widgets/myButton.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
              const TextField(
                decoration: InputDecoration(
                    hintText: "Enter your email address or username",
                    label: Text("Enter your email address or username")),
              ),
              const TextField(
                decoration: InputDecoration(
                    hintText: "Enter your password",
                    label: Text("Enter your Password")),
              ),
              MyButton(
                buttonText: "LOGIN",
                buttonColor: Colors.grey,
                onTap: () {},
              ),
              const Text(
                "Forgot password?",
              ),
              GoogleAuthButton(
                onPressed: () {},
              ),
              FacebookAuthButton(
                onPressed: () {},
              ),
              const Text("Don't have an account? Register"),
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
