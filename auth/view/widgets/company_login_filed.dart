import 'package:flutter/material.dart';
import 'package:futrah/controller/constants/size.dart';
import 'package:futrah/controller/resources/localizations/app_localizations.dart';
import 'package:futrah/controller/resources/theme/colors_manager.dart';
import 'package:futrah/view/widgets/my_text.dart';

class CompanyTextFiled extends StatelessWidget {
  final TextEditingController controller;
  final String title, hintText;
  final bool? validate;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Function(String)? onFieldSubmitted;

  const CompanyTextFiled({
    super.key,
    required this.controller,
    required this.title,
    required this.hintText,
    this.validate = true,
    this.keyboardType,
    this.textInputAction,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            MyText(
              title: title,
              fontWeight: FontWeight.w400,
            ),
          ],
        ),
        3.h,
        TextFormField(
          keyboardType: keyboardType ?? TextInputType.text,
          controller: controller,
          cursorColor: Colors.black,
          textInputAction: textInputAction ?? TextInputAction.next,
          style: const TextStyle(
            fontSize: 18,
            color: AppColors.primaryColor,
            fontWeight: FontWeight.w800,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              fontSize: 16,
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w400,
            ),
            filled: true,
            fillColor: AppColors.white,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            border: buildOutlineInputBorder,
            focusedBorder: buildOutlineInputBorder,
            enabledBorder: buildOutlineInputBorder,
          ),
          validator: validate == false
              ? null
              : (value) {
                  if (value!.isEmpty) {
                    return 'please_fill_this_field'.tr(context);
                  }
                  return null;
                },
          onFieldSubmitted: onFieldSubmitted,
        ),
      ],
    );
  }

  OutlineInputBorder get buildOutlineInputBorder {
    return const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent, width: 2),
    );
  }
}
