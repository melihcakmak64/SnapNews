import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyButton extends StatelessWidget {
  const MyButton(
      {super.key,
      required this.buttonText,
      required this.buttonColor,
      this.onTap});
  final String buttonText;
  final Color buttonColor;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: Get.size.height * 0.08,
          width: double.infinity,
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
              child: Text(
            buttonText,
            style: TextStyle(color: Colors.white),
          )),
        ),
      ),
    );
  }
}
