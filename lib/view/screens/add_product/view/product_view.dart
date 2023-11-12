part of 'product_imports.dart';

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ProductCubit(),
      child: BlocConsumer<ProductCubit, ProductState>(
        listener: (context, state) {
          if (state is AddProductSuccessState) {
            pushReplacementNamed(context, Routes.home);
          }
        },
        builder: (context, state) {
          var cubit = ProductCubit.get(context);
          return CustomCondition(
            state: state is! AddProductLoadingState,
            body: Form(
              key: cubit.formKey,
              child: Scaffold(
                appBar: const CustomAppBar(),
                body: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      const ProductPickImage(),
                      25.h,
                      const AddProductColumnFields(),
                      30.h,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          MyText(
                            title: 'tax_state'.tr(context),
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                      const TaxRow(),
                      AppButton(
                        text: 'add'.tr(context),
                        color: AppColors.green,
                        height: 50,
                        borderRadius: BorderRadius.circular(6),
                        onPressed: () {
                          // if (cubit.selectedCategory.isEmpty) {
                          //   productErrorSnackBar(context);
                          // } else {
                            if (cubit.productName.text.isNotEmpty &&
                                cubit.productPrice.text.isNotEmpty &&
                                cubit.image.path.isNotEmpty) {
                              cubit.addProduct().then(
                                (value) {
                                  successSnackBar(
                                      msg: 'product_added_successfully'
                                          .tr(context));
                                },
                              );
                            }
                       //   }
                        },
                      ),
                    ],
                  ),
                ),
                // bottomNavigationBar: AuthBtn(
                //   title: 'start_selling'.tr(context),
                //   onTap: () =>
                //       pushReplacementNamed(context,  KeyPath.home),
                // ),
              ),
            ),
          );
        },
      ),
    );
  }

  void productErrorSnackBar(BuildContext context) {
    errorSnackBar(msg: 'please_fill_all_fields'.tr(context));
  }
}
