part of 'customers_imports.dart';

class AddCustomersScreen extends StatelessWidget {
  const AddCustomersScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomersCubit, CustomersState>(
      listener: (context, state) {
        if (state is AddCustomersLoadingState) const AppLoading();
        if (state is GetCustomersLoadingState) const AppLoading();
        if (state is DeleteCustomersLoadingState) const AppLoading();
        if (state is AddCustomersSuccessState) {
          successSnackBar(msg: 'add_client_success'.tr(context));
        }
      },
      builder: (context, state) {
        var cubit = CustomersCubit.get(context);
        return Scaffold(
          appBar: const CustomAppBar(),
          body: CustomCondition(
            state: state is! GetCustomersLoadingState,
            body: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              physics: const BouncingScrollPhysics(),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    MyText(
                      title: 'add_customers'.tr(context),
                      size: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
                10.h,
                const CustomersListItem(),
                15.h,
                const TextFiledPart(),
                10.h,
                AppButton(
                  text: 'add'.tr(context),
                  color: AppColors.green,
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  borderRadius: BorderRadius.circular(6),
                  onPressed: () {
                    cubit.customersName.text.isEmpty ||
                            cubit.customersPhone.text.isEmpty
                        ? errorSnackBar(
                            msg: 'please_fill_this_field'.tr(context))
                        : cubit.addCustomers();
                  },
                ),
              ],
            ),
          ),
          bottomNavigationBar: AuthBtn(
            title: 'back_to_home'.tr(context),
            onTap: () {
              cubit.customersName.text.isEmpty ||
                      cubit.customersPhone.text.isEmpty
                  ? errorSnackBar(msg: 'please_fill_this_field'.tr(context))
                  : pushReplacementNamed(context, Routes.home);
            },
          ),
        );
      },
    );
  }
}
