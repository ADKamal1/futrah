import 'package:flutter/material.dart';
import 'package:futrah/controller/resources/localizations/app_localizations.dart';
import 'package:futrah/view/widgets/my_text.dart';

class NoData extends StatelessWidget {
  final String? title;
  final double? height;
  const NoData({super.key, this.title, this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? MediaQuery.of(context).size.height * 0.3,
      child: Center(
        child: MyText(
          title: title ?? 'no_products_added'.tr(context),
          size: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
