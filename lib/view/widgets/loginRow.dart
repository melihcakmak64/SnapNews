import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginRow extends StatelessWidget {
  const LoginRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GoogleAuthButton(
          onPressed: () {},
          style: const AuthButtonStyle(
            buttonType: AuthButtonType.icon,
            iconType: AuthIconType.secondary,
          ),
        ),
        FacebookAuthButton(
          onPressed: () {},
          style: const AuthButtonStyle(
            buttonType: AuthButtonType.secondary,
            iconType: AuthIconType.secondary,
          ),
        )
      ],
    );
  }
}
