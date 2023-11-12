part of 'app_router_imports.dart';

class RoutesGenerator {
  PhoneAuthCubit? phoneAuthCubit;
  LoginCubit?loginCubit;
  RoutesGenerator() {
    phoneAuthCubit = PhoneAuthCubit();
    loginCubit=LoginCubit();

  }

  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return _move(const SplashScreen());
      case Routes.login:
        return _move(
          BlocProvider<PhoneAuthCubit>.value(
            value: phoneAuthCubit!,
            child: const LoginScreen(),
          ),
        );
      case Routes.signUp:
        return _move(
          BlocProvider<LoginCubit>.value(
            value: loginCubit!  ,
            child: const RegisterScreen(),
          ),
        );

      case Routes.otp:
        final phoneNumber = settings.arguments;
        return _move(
          BlocProvider<PhoneAuthCubit>.value(
            value: phoneAuthCubit!,
            child: OtpScreen(phoneNumber: phoneNumber.toString()),
          ),
        );

      case Routes.home:
        return _move(
          BlocProvider<HomeCubit>(
            create: (BuildContext context) => HomeCubit()..getCategories(),
            child: const HomeScreen(),
          ),
        );

      case Routes.profile:
        return _move(
          BlocProvider<ProfileCubit>(
            create: (BuildContext context) => ProfileCubit()..getProfileData(),
            child: const ProfileScreen(),
          ),
        );

      case Routes.aboutUs:
        return _move(
          const AboutUs(),
        );

      case Routes.policy:
        return _move(
          const PolicyScreen(),
        );

      case Routes.company:
        return _move(
          BlocProvider<CompanyCubit>(
            create: (BuildContext context) => CompanyCubit(),
            child: const CompanyScreen(),
          ),
        );

      case Routes.category:
        return _move(
          BlocProvider<CategoryCubit>(
            create: (BuildContext context) => CategoryCubit()..getCategories(),
            child: const AddCategoryScreen(),
          ),
        );

      case Routes.addProduct:
        return _move(
          MultiBlocProvider(
            providers: [
              BlocProvider<CategoryCubit>(
                  create: (context) => CategoryCubit()..getCategories()),
              BlocProvider<ProductCubit>(create: (context) => ProductCubit()),
            ],
            child: const AddProductScreen(),
          ),
        );

      case Routes.pay:
        final totalPrice = settings.arguments as int;
        final productList = settings.arguments as List<int>;
        final idList = settings.arguments as Map;

        return _move(
          BlocProvider<PayCubit>(
            create: (BuildContext context) => PayCubit(),
            child: PayScreen(
              totalPrice: totalPrice,
              productList: productList,
              idList: idList,
            ),
          ),
        );

      case Routes.quickPayment:
        return _move(
          BlocProvider<QuickPayCubit>(
            create: (BuildContext context) => QuickPayCubit(),
            child: const QuickPayScreen(),
          ),
        );

      case Routes.plans:
        return _move(
          BlocProvider<SubscriptionCubit>(
            create: (BuildContext context) =>
                SubscriptionCubit()..getSubscriptions(),
            child: const SubscriptionPlansScreen(),
          ),
        );

      case Routes.customers:
        return _move(
          BlocProvider<CustomersCubit>(
            create: (BuildContext context) => CustomersCubit()..getCustomers(),
            child: const AddCustomersScreen(),
          ),
        );

      case Routes.bills:
        return _move(
          BlocProvider<BillsCubit>(
            create: (BuildContext context) => BillsCubit()..getAllBills(),
            child: const BillsScreen(),
          ),
        );

      case Routes.editProfile:
        return _move(
          BlocProvider<ProfileCubit>(
            create: (BuildContext context) => ProfileCubit(),
            child: const EditProfile(),
          ),
        );
    }
    return null;
  }

  static PageRoute _move(Widget screen) {
    return MaterialPageRoute(
      builder: (context) => screen,
    );
  }
}
