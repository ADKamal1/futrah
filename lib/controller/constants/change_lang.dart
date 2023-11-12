import 'package:flutter/material.dart';
import 'package:futrah/controller/constants/app_images.dart';
import 'package:futrah/controller/resources/localizations/lang_cubit/locale_cubit.dart';

changeLanguage(context) {
  var languageCode =
      Localizations.localeOf(context).languageCode == 'ar' ? 'en' : 'ar';
  LocaleCubit.get(context).changeLanguage(languageCode);
}

String langLogo(context) {
  var lang = Localizations.localeOf(context).languageCode == 'ar';
  return lang ? AppImages.logo : AppImages.logoEn;
}
