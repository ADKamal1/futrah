import 'package:flutter/material.dart';
import 'package:futrah/controller/constants/size.dart';
import 'package:futrah/controller/resources/localizations/app_localizations.dart';
import 'package:futrah/controller/resources/theme/colors_manager.dart';
import 'package:futrah/view/widgets/my_text.dart';

class PayTextFiled extends StatelessWidget {
  final TextEditingController controller;
  final String title, hintText;
  final IconData icon;
  final bool? validate;
  final TextInputType? keyboardType;
  const PayTextFiled({
    super.key,
    required this.controller,
    required this.title,
    required this.hintText,
    this.validate = true,
    required this.icon,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        children: [
          Row(
            children: [
              MyText(title: title, size: 18, fontWeight: FontWeight.w400),
            ],
          ),
          5.h,
          TextFormField(
            controller: controller,
            cursorColor: Colors.black,
            keyboardType: keyboardType ?? TextInputType.text,
            style: const TextStyle(
              fontSize: 18,
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w800,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.white,
              hintText: hintText.tr(context),
              hintStyle: const TextStyle(
                fontSize: 16,
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w400,
              ),
              contentPadding: const EdgeInsets.all(10),
              border: buildOutlineInputBorder,
              focusedBorder: buildOutlineInputBorder,
              enabledBorder: buildOutlineInputBorder,
              suffixIcon: Icon(
                icon,
                color: AppColors.primaryColor,
              ),
            ),
            validator: validate == false
                ? null
                : (value) {
                    if (value!.isEmpty) {
                      return 'please_fill_this_field'.tr(context);
                    }
                    return null;
                  },
            onFieldSubmitted: (_) {},
          ),
        ],
      ),
    );
  }

  OutlineInputBorder get buildOutlineInputBorder {
    return const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent, width: 2),
    );
  }
}
