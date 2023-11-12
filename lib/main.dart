// ignore_for_file: depend_on_referenced_packages

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:futrah/controller/app/multiProviders/providers_imports.dart';
import 'package:futrah/controller/constants/strings.dart';
import 'package:futrah/controller/resources/localizations/app_localizations.dart';
import 'package:futrah/controller/resources/localizations/lang_cubit/locale_cubit.dart';
import 'package:futrah/controller/resources/theme/theme_manager.dart';
import 'package:futrah/controller/routes/app_router_imports.dart';
import 'package:futrah/controller/services/helpers/bloc_observer.dart';
import 'package:futrah/controller/services/helpers/custom_error_screen.dart';
import 'package:futrah/controller/services/helpers/di.dart';
import 'package:futrah/controller/services/local/cache_helper.dart';
import 'package:futrah/controller/services/local/utils.dart';
import 'package:futrah/controller/services/remote/dio_helper.dart';
import 'package:futrah/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  customErrorScreen();
  await initApp();
  await DioHelper.init();
  CacheHelper.init();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final CacheHelper prefs = instance<CacheHelper>();
  AppStrings.loginToken = prefs.get(key: 'token') ?? '';
  print(prefs.get(key: 'token'));
  AppStrings.userPhone = prefs.get(key: 'phone') ?? '';
  AppStrings.userUid = prefs.get(key: 'uid') ?? '';
  AppStrings.userId = prefs.get(key: 'userId') ?? 0;
  Utils().printLocal;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: MainData.providers(context),
      child: BlocBuilder<LocaleCubit, LocaleState>(
        builder: (context, state) {
          return MaterialApp(
            title: AppStrings.appName,
            debugShowCheckedModeBanner: false,
            theme: ThemeManager.theme,
            initialRoute: Routes.splash,
            onGenerateRoute: RoutesGenerator().onGenerateRoute,
            locale: state.locale,
            supportedLocales: const [Locale('ar'), Locale('en')],
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate
            ],
            localeResolutionCallback: (deviceLocale, supportedLocales) {
              for (var locale in supportedLocales) {
                if (deviceLocale != null &&
                    deviceLocale.languageCode == locale.languageCode) {
                  return deviceLocale;
                }
              }
              return supportedLocales.first;
            },
            builder: (BuildContext context, Widget? child) {
              return Scaffold(
                body: InkWell(onTap: null, child: child),
              );
            },
          );
        },
      ),
    );
  }
}
