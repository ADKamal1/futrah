import 'dart:async';

import 'package:flutter/material.dart';
import 'package:futrah/controller/constants/change_lang.dart';
import 'package:futrah/controller/constants/strings.dart';
import 'package:futrah/controller/integration/bluetooth/print_page.dart';
import 'package:futrah/controller/resources/localizations/language_cache_helper.dart';
import 'package:futrah/controller/routes/app_router_imports.dart';
import 'package:futrah/view/screens/auth/view/register/register_imports.dart';
import 'package:futrah/view/screens/quick_bill/cubit/quick_printers/quick_print_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // late String route;
    // //AppStrings.loginToken.isEmpty ?
    // route = Routes.signUp;
    // //: route = Routes.login ;
    //
    // Future.delayed(
    //   const Duration(milliseconds: AppStrings.splashDuration),
    //
    //   () =>pushReplacementNamed(context,route),
    // );
    // super.initState();
    late String route;
    AppStrings.loginToken.isEmpty?   route = Routes.signUp : route = Routes.login ;

    Future.delayed(
      const Duration(milliseconds: AppStrings.splashDuration),

          () =>pushReplacementNamed(context,route),
    );
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset(langLogo(context))),
    );
  }
}
