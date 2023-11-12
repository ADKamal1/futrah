import 'package:flutter/material.dart';
import 'package:futrah/controller/constants/change_lang.dart';
import 'package:futrah/controller/resources/localizations/app_localizations.dart';
import 'package:futrah/controller/resources/theme/colors_manager.dart';
import 'package:futrah/view/widgets/my_text.dart';

class DrawerItem extends StatelessWidget {
  final String title;
  final void Function() onTap;
  final IconData? icon;
  final Color? color;

  const DrawerItem({
    super.key,
    required this.title,
    required this.onTap,
    this.icon,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 15),
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyText(
              title: title,
              size: 22,
              fontWeight: FontWeight.bold,
              color: color,
            ),
            Icon(icon ?? Icons.arrow_forward_ios, color: color),
          ],
        ),
      ),
    );
  }
}

class DrawerLangBtn extends StatelessWidget {
  const DrawerLangBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => changeLanguage(context),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 15),
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyText(
              title: 'change_lang'.tr(context),
              fontWeight: FontWeight.bold,
            ),
            ElevatedButton(
              style: styleFrom,
              onPressed: () => changeLanguage(context),
              child: MyText(title: 'lang'.tr(context), color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

ButtonStyle get styleFrom {
  return ElevatedButton.styleFrom(
    foregroundColor: Colors.white,
    backgroundColor: AppColors.green,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))),
  );
}
