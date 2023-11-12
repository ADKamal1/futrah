import 'package:flutter/material.dart';
import 'package:futrah/controller/constants/change_lang.dart';
import 'package:futrah/controller/constants/size.dart';
import 'package:futrah/controller/resources/localizations/app_localizations.dart';
import 'package:futrah/controller/resources/theme/colors_manager.dart';
import 'package:futrah/view/widgets/my_text.dart';

class LangBtn extends StatelessWidget {
  const LangBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          MyText(
            title: 'change_lang'.tr(context),
            size: 14,
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
          10.w,
          ElevatedButton(
            onPressed: () => changeLanguage(context),
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.green),
            child: MyText(
              title: 'lang'.tr(context),
              size: 14,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
