part of 'company_imports.dart';

class CompanyScreen extends StatelessWidget {
  const CompanyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CompanyCubit(),
      child: BlocConsumer<CompanyCubit, CompanyState>(
        listener: (context, state) {
          var cubit = CompanyCubit.get(context);
          if (state is CompanyLoadingState) const AppLoading();
          if (state is CompanyErrorState) {
            errorSnackBar(msg: cubit.companyModel!.errors!.error![0]);
          }
          if (state is CompanySuccessState) {
            successSnackBar(msg: cubit.companyModel!.message!);
            pushReplacementNamed(context, Routes.category);
          }
        },
        builder: (context, state) {
          var cubit = CompanyCubit.get(context);
          return Form(
            key: cubit.formKey,
            child: Scaffold(
              appBar: const CustomAppBar(),
              body: CustomCondition(
                state: state is! CompanyLoadingState,
                body: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: Column(
                      children: [
                        const CompanyPickImage(),
                        30.h,
                        CompanyTextFiled(
                          controller: cubit.nameController,
                          title: 'company_name'.tr(context),
                          hintText: 'add_name_hint'.tr(context),
                        ),
                        3.h,
                        CompanyTextFiled(
                          controller: cubit.addressController,
                          title: 'company_address'.tr(context),
                          hintText: 'company_address_hint'.tr(context),
                        ),
                        3.h,
                        CompanyTextFiled(
                          controller: cubit.taxNumberController,
                          title: 'company_tax_number'.tr(context),
                          hintText: 'company_tax_number_hint'.tr(context),
                          keyboardType: TextInputType.number,
                        ),
                        3.h,
                        CompanyTextFiled(
                          controller: cubit.taxRateController,
                          title: 'company_tax_percent'.tr(context),
                          hintText: 'company_tax_percent_hint'.tr(context),
                          keyboardType: TextInputType.number,
                          onFieldSubmitted: (value) {
                            if (cubit.formKey.currentState!.validate() &&
                                cubit.image != null) {
                              cubit.updateCompanyData();
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
                title: 'add_company'.tr(context),
                onTap: () {
                  if (cubit.formKey.currentState!.validate() &&
                      cubit.image != null) {
                    cubit.updateCompanyData();
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
