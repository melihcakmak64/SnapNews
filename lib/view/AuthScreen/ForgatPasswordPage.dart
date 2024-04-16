import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/widgets/myButton.dart';
import 'package:get/get.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              "SnapNews",
              style: TextStyle(fontSize: 48),
            ),
            SizedBox(
              height: Get.size.height * 0.2,
            ),
            const Text(
              "Enter your email to be sent a reset password link.",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: const TextField(
                decoration:
                    InputDecoration(hintText: "Email", label: Text("Email")),
              ),
            ),
            const MyButton(buttonText: "Reset", buttonColor: Colors.grey)
          ],
        ),
      ),
    );
  }
}
