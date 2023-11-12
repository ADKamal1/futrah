import 'package:flutter/material.dart';
import 'package:futrah/controller/resources/localizations/app_localizations.dart';
import 'package:futrah/controller/resources/theme/colors_manager.dart';
import 'package:futrah/view/widgets/my_text.dart';

class LoginTermsCheck extends StatelessWidget {
  final bool isChecked;
  final Function(bool) onChanged;

  const LoginTermsCheck(
      {super.key, required this.isChecked, required this.onChanged});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: isChecked,
          onChanged: (value) => onChanged(value!),
          activeColor: AppColors.primaryColor,
        ),
        MyText(
          title: 'accept_terms_conditions'.tr(context),
        ),
      ],
    );
  }
}
