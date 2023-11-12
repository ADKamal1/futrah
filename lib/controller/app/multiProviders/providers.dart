part of 'providers_imports.dart';

class MainData {
  static List<BlocProvider> providers(BuildContext context) => [
        BlocProvider<LocaleCubit>(
            create: (context) => LocaleCubit()..getSavedLanguage()),
        BlocProvider<PhoneAuthCubit>(create: (context) => PhoneAuthCubit()),
        BlocProvider<CompanyCubit>(create: (context) => CompanyCubit()),
        BlocProvider<ProductCubit>(create: (context) => ProductCubit()),
        BlocProvider<PayCubit>(create: (context) => PayCubit()),
        BlocProvider<QuickPayCubit>(create: (context) => QuickPayCubit()),
        BlocProvider<CustomersCubit>(
            create: (context) => CustomersCubit()..getCustomers()),
        BlocProvider<CategoryCubit>(
            create: (context) => CategoryCubit()..getCategories()),
        BlocProvider<HomeCubit>(
            create: (context) => HomeCubit()..getCategories()),
        BlocProvider<ProfileCubit>(
            create: (context) => ProfileCubit()..getProfileData()),
        BlocProvider<SubscriptionCubit>(
            create: (context) => SubscriptionCubit()..getSubscriptions()),
        BlocProvider<BillsCubit>(
            create: (context) => BillsCubit()..getAllBills()),
      ];
}
