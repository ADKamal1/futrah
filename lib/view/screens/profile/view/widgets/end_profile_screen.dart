import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:futrah/controller/constants/size.dart';
import 'package:futrah/controller/constants/url_launcher.dart';
import 'package:futrah/controller/resources/localizations/app_localizations.dart';
import 'package:futrah/controller/resources/theme/colors_manager.dart';
import 'package:futrah/controller/routes/app_router_imports.dart';
import 'package:futrah/view/screens/profile/cubit/profile_cubit.dart';
import 'package:futrah/view/screens/profile/cubit/profile_states.dart';
import 'package:futrah/view/screens/profile/view/widgets/profile_item.dart';
import 'package:futrah/view/widgets/my_text.dart';

class EndProfileScreen extends StatelessWidget {
  const EndProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileStates>(
      builder: (context, state) {
        var cubit = ProfileCubit.get(context);
        var contactUs = cubit.userModel!.data!.contactUs![0].phone;
        return Column(
          children: [
            ProfileItem(
              onTap: () => pushNamed(context, route: Routes.aboutUs),
              title: 'about_us'.tr(context),
            ),
            ProfileItem(
              onTap: () => pushNamed(context, route: Routes.policy),
              title: 'policy'.tr(context),
            ),
            ProfileItem(
              onTap: () {
                LauncherUtils.launchPhone(phone: contactUs);
              },
              title: 'call_us'.tr(context),
            ),
            ProfileItem(
              onTap: () => cubit
                  .logOut()
                  .then((value) => pushReplacementNamed(context, Routes.login)),
              title: 'logout'.tr(context),
            ),
            30.h,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
              child: InkWell(
                onTap: () {
                  cubit.deleteAccount().then(
                      (value) => pushReplacementNamed(context, Routes.login));
                },
                child: Column(
                  children: [
                    Row(
                      children: [
                        MyText(
                          title: 'delete_account'.tr(context),
                          color: AppColors.red,
                          fontWeight: FontWeight.bold,
                        ),
                        const Spacer(),
                        const Icon(Icons.delete_forever, color: AppColors.red),
                      ],
                    ),
                    Container(
                      height: 3,
                      width: MediaQuery.of(context).size.width - 50,
                      color: AppColors.red,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
