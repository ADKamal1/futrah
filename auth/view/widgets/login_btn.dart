import 'package:flutter/material.dart';
import 'package:futrah/controller/resources/theme/colors_manager.dart';
import 'package:futrah/view/widgets/cancel_button.dart';

class AuthBtn extends StatelessWidget {
  final Function onTap;
  final String title;

  const AuthBtn({super.key, required this.onTap, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppButton(
      height: 70,
      borderRadius: BorderRadius.zero,
      color: AppColors.primaryColor,
      onPressed: onTap,
      text: title,
      fontSize: 20,
    );
  }
}
