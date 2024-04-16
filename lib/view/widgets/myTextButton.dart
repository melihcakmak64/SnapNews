import 'package:flutter/material.dart';

class MyTextButton extends StatelessWidget {
  const MyTextButton(
      {super.key, required this.buttonText, required this.onTap});
  final String buttonText;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: onTap, child: Text(buttonText));
  }
}
