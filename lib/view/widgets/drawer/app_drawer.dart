import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:futrah/controller/constants/change_lang.dart';
import 'package:futrah/controller/constants/size.dart';
import 'package:futrah/controller/resources/localizations/app_localizations.dart';
import 'package:futrah/controller/resources/theme/colors_manager.dart';
import 'package:futrah/controller/routes/app_router_imports.dart';
import 'package:futrah/view/screens/profile/cubit/profile_cubit.dart';
import 'package:futrah/view/screens/profile/cubit/profile_states.dart';
import 'package:futrah/view/widgets/drawer/drawer_items.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ProfileCubit.get(context);
        var model = cubit.userModel?.data;
        return Container(
          width: MediaQuery.of(context).size.width * 0.75,
          color: Colors.white,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Center(
                child: Image.asset(langLogo(context), height: 150, width: 150),
              ),
              const Divider(color: AppColors.primaryColor, thickness: 1),
              DrawerItem(
                title: 'home'.tr(context),
                onTap: () => pushReplacementNamed(context, Routes.home),
              ),
              DrawerItem(
                title: 'profile'.tr(context),
                onTap: () {
                  pop(context);
                  pushNamed(context, route: Routes.profile);
                },
              ),
              DrawerItem(
                title: 'my_categories'.tr(context),
                onTap: () {
                  pop(context);
                  pushNamed(context, route: Routes.category);
                },
              ),
              DrawerItem(
                title: 'my_products'.tr(context),
                onTap: () {
                  pop(context);
                  pushNamed(context, route: Routes.addProduct);
                },
              ),
              model!.days! <= 14
                  ? DrawerItem(
                      title: 'drawer_subscriptions'.tr(context),
                      onTap: () {
                        pop(context);
                        pushNamed(context, route: Routes.plans);
                      },
                    )
                  : 0.h,
              DrawerItem(
                title: 'customers'.tr(context),
                onTap: () {
                  pop(context);
                  pushNamed(context, route: Routes.customers);
                },
              ),
              DrawerItem(
                title: 'drawer_bills'.tr(context),
                onTap: () {
                  pop(context);
                  pushNamed(context, route: Routes.bills);
                },
              ),
              DrawerItem(
                title: 'logout'.tr(context),
                icon: Icons.logout,
                onTap: () => cubit.logOut().then(
                    (value) => pushReplacementNamed(context, Routes.login)),
              ),
              10.h,
              const DrawerLangBtn(),
            ],
          ),
        );
      },
    );
  }
}
