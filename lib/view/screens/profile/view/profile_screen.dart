part of 'profile_imports.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileStates>(
      listener: (context, state) {
        if (state is ProfileLoadingUserState) const AppLoading();
        if (state is ProfileErrorUserState) errorSnackBar(msg: state.error);
      },
      builder: (context, state) {
        var model = ProfileCubit.get(context).userModel?.data;
        String subscriptionDays =
            '${'subscription_end_date'.tr(context)}${model?.days}${'day'.tr(context)}';
        return Scaffold(
          appBar: CustomAppBar(
            actions: [
              IconButton(
                onPressed: () => pushNamed(context, route: Routes.editProfile),
                icon: const Icon(Icons.edit, size: 30),
              )
            ],
          ),
          body: CustomCondition(
            state: model != null,
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Column(
                children: [
                  MyText(
                    title: 'my_account'.tr(context),
                    size: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  20.h,
                  const ProfileImage(),
                  30.h,
                  MyText(
                    title: model?.name ?? 'company_name'.tr(context),
                    size: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  5.h,
                  MyText(
                    title: subscriptionDays,
                    size: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  15.h,
                  model?.isSubscriptionEnd == true
                      ? AppButton(
                          height: 50,
                          width: 200,
                          onPressed: () =>
                              pushNamed(context, route: Routes.plans),
                          text: 'renew_subscription'.tr(context),
                          color: AppColors.green,
                          borderRadius: BorderRadius.circular(8),
                        )
                      : 0.h,
                  40.h,
                  const EndProfileScreen(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
