import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/view/AuthScreen/LoginPage.dart';
import 'package:flutter_application_1/view/widgets/myButton.dart';
import 'package:flutter_application_1/view/widgets/myTextButton.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

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
              const TextField(
                decoration: InputDecoration(
                    hintText: "Enter your email address",
                    label: Text("Enter your email address")),
              ),
              const TextField(
                decoration: InputDecoration(
                    hintText: "Enter your username",
                    label: Text("Enter your username")),
              ),
              const TextField(
                decoration: InputDecoration(
                    hintText: "Enter your password",
                    label: Text("Enter your Password")),
              ),
              const TextField(
                decoration: InputDecoration(
                    hintText: "Country/Region", label: Text("Country/Region")),
              ),
              MyButton(
                buttonText: "REGISTER",
                buttonColor: Colors.grey,
                onTap: () {},
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
