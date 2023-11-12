import 'package:flutter/material.dart';
import 'package:futrah/controller/constants/size.dart';
import 'package:futrah/controller/resources/localizations/app_localizations.dart';
import 'package:futrah/controller/resources/theme/colors_manager.dart';
import 'package:futrah/view/widgets/my_text.dart';

class AddCategoryTextFiled extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final String? title;
  final IconData? suffixIcon;
  final TextInputType? keyboardType;
  final Function(String)? onSubmitted;

  const AddCategoryTextFiled({
    super.key,
    this.controller,
    required this.hintText,
    this.suffixIcon,
    this.title,
    this.keyboardType,
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
              MyText(title: title ?? 'enter_cat_name'.tr(context), size: 16),
            ],
          ),
          7.h,
          SizedBox(
            height: 50,
            child: TextFormField(
              controller: controller,
              cursorColor: Colors.black,
              keyboardType: keyboardType ?? TextInputType.text,
              onFieldSubmitted: onSubmitted,
              style: const TextStyle(
                fontSize: 18,
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w800,
              ),
              decoration: InputDecoration(
                suffixIcon: Icon(
                  suffixIcon,
                  color: AppColors.primaryColor,
                ),
                hintText: hintText,
                border: OutlineInputBorder(borderSide: borderSide),
                focusedBorder: OutlineInputBorder(borderSide: borderSide),
                enabledBorder: OutlineInputBorder(borderSide: borderSide),
                filled: true,
                fillColor: AppColors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  BorderSide get borderSide =>
      const BorderSide(color: Colors.transparent, width: 2);
}
