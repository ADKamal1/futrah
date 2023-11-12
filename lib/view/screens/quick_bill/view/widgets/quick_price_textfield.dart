import 'package:flutter/material.dart';
import 'package:futrah/controller/resources/localizations/app_localizations.dart';
import 'package:futrah/controller/resources/theme/colors_manager.dart';

class QuickPriceTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool validate;

  const QuickPriceTextField({
    super.key,
    required this.controller,
    this.validate = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textAlignVertical: TextAlignVertical.center,
      textAlign: TextAlign.center,
      keyboardType: TextInputType.number,
      style: const TextStyle(color: AppColors.green, fontSize: 40),
      validator: validate == false
          ? null
          : (value) {
              if (value!.isEmpty) {
                return 'please_fill_this_field'.tr(context);
              }
              return null;
            },
      decoration: InputDecoration(
        hintText: 'enter_price'.tr(context),
        hintStyle: const TextStyle(color: AppColors.green, fontSize: 40),
        enabledBorder: underlineBorder,
        focusedBorder: underlineBorder,
      ),
    );
  }

  UnderlineInputBorder get underlineBorder {
    return const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.grey));
  }
}
