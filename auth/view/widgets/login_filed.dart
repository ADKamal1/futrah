import 'package:flutter/material.dart';
import 'package:futrah/controller/constants/size.dart';
import 'package:futrah/controller/resources/theme/colors_manager.dart';
import 'package:futrah/view/widgets/my_text.dart';

class AuthTextFiled extends StatelessWidget {
  final TextEditingController? controller;
  final String title;
  final IconData? prefix;
  final IconData? suffix;
  final void Function()? suffixPressed;
  final TextInputType? keyboardType;
  final bool isPassword;
  final String? Function(String?)? validator;
  final void Function(String)? onSubmitted;

  const AuthTextFiled({
    super.key,
    this.controller,
    required this.title,
    this.suffixPressed,
    this.keyboardType,
    required this.isPassword,
    this.prefix,
    this.suffix,
    this.validator,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              MyText(title: title, size: 16),
            ],
          ),
          5.h,
          Directionality(
            textDirection: TextDirection.ltr,
            child: TextFormField(
              validator: validator,
              textDirection: TextDirection.ltr,
              controller: controller,
              autofocus: true,
              obscureText: isPassword,
              keyboardType: keyboardType,
              cursorColor: Colors.black,
              onFieldSubmitted: (value) => onSubmitted!(value),
              style: const TextStyle(
                fontSize: 18,
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w800,
              ),
              decoration: InputDecoration(
                border: outlineBorder,
                focusedBorder: outlineBorder,
                enabledBorder: outlineBorder,
                filled: true,
                fillColor: AppColors.white,
                prefixIcon: Icon(prefix, color: AppColors.primaryColor),
                suffixIcon: suffix != null
                    ? IconButton(
                        onPressed: suffixPressed,
                        icon: Icon(suffix, color: AppColors.primaryColor),
                      )
                    : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

OutlineInputBorder get outlineBorder => const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent, width: 2),
    );
