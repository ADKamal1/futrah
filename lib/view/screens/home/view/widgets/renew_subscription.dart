import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:futrah/controller/constants/size.dart';
import 'package:futrah/controller/resources/localizations/app_localizations.dart';
import 'package:futrah/controller/resources/theme/colors_manager.dart';
import 'package:futrah/controller/routes/app_router_imports.dart';
import 'package:futrah/view/screens/profile/cubit/profile_cubit.dart';
import 'package:futrah/view/screens/profile/cubit/profile_states.dart';
import 'package:futrah/view/widgets/cancel_button.dart';
import 'package:futrah/view/widgets/custom_app_bar.dart';
import 'package:futrah/view/widgets/my_text.dart';

class SubscriptionEnd extends StatelessWidget {
  const SubscriptionEnd({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileStates>(
      builder: (context, state) {
        var cubit = ProfileCubit.get(context);
        return Scaffold(
          appBar: CustomAppBar(
            leading: IconButton(
              onPressed: () => cubit
                  .logOut()
                  .then((value) => pushReplacementNamed(context, Routes.login)),
              icon: const Icon(Icons.logout, size: 30),
            ),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyText(
                  title: 'subscription_end_renew'.tr(context),
                  alien: TextAlign.center,
                  size: 25,
                  maxLines: 2,
                  fontWeight: FontWeight.bold,
                ),
                20.h,
                AppButton(
                  height: 50,
                  width: 200,
                  onPressed: () => pushNamed(context, route: Routes.plans),
                  text: 'renew_subscription'.tr(context),
                  color: AppColors.primaryColor,
                  fontSize: 18,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
