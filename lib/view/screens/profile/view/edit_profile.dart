part of 'profile_imports.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ProfileCubit(),
      child: BlocConsumer<ProfileCubit, ProfileStates>(
        listener: (context, state) {
          var cubit = ProfileCubit.get(context);
          if (state is EditProfileLoadingState) const AppLoading();
          if (state is EditProfileErrorState) {
            errorSnackBar(msg: cubit.companyModel!.errors!.error![0]);
          }
          if (state is EditProfileSuccessState) {
            successSnackBar(msg: cubit.companyModel!.message!);
            pushReplacementNamed(context, Routes.home);
          }
        },
        builder: (context, state) {
          var cubit = ProfileCubit.get(context);
          return Form(
            key: cubit.formKey,
            child: Scaffold(
              appBar: const CustomAppBar(),
              body: CustomCondition(
                state: state is! EditProfileLoadingState,
                body: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: Column(
                      children: [
                        const UploadImage(),
                        30.h,
                        CompanyTextFiled(
                          controller: cubit.nameController,
                          title: 'company_name'.tr(context),
                          hintText: 'add_name_hint'.tr(context),
                        ),
                        CompanyTextFiled(
                          controller: cubit.addressController,
                          title: 'company_address'.tr(context),
                          hintText: 'company_address_hint'.tr(context),
                        ),
                        CompanyTextFiled(
                          controller: cubit.taxNumberController,
                          title: 'company_tax_number'.tr(context),
                          hintText: 'company_tax_number_hint'.tr(context),
                          keyboardType: TextInputType.number,
                        ),
                        CompanyTextFiled(
                          controller: cubit.taxRateController,
                          title: 'company_tax_percent'.tr(context),
                          hintText: 'company_tax_percent_hint'.tr(context),
                          keyboardType: TextInputType.number,
                          onFieldSubmitted: (value) {
                            if (cubit.formKey.currentState!.validate() &&
                                cubit.image != null) {
                              cubit.updateProfile();
                            } else {
                              errorSnackBar(
                                  msg: 'please_fill_this_field'.tr(context));
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              bottomNavigationBar: AuthBtn(
                title: 'update_account'.tr(context),
                onTap: () {
                  if (cubit.formKey.currentState!.validate() &&
                      cubit.image != null) {
                    cubit.updateProfile();
                  } else {
                    errorSnackBar(msg: 'please_fill_this_field'.tr(context));
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
