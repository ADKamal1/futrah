part of 'quick_payment_imports.dart';

class QuickPayScreen extends StatelessWidget {
  const QuickPayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuickPayCubit, QuickBillStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = QuickPayCubit.get(context);
        return CustomCondition(
          state: state is! MakeQuickBillLoadingState,
          body: Scaffold(
            appBar: const CustomAppBar(),
            body: Form(
              key: cubit.formKey,
              child: Column(
                children: [
                  MyText(
                    title: 'price'.tr(context),
                    alien: TextAlign.center,
                    size: 54,
                    fontWeight: FontWeight.bold,
                  ),
                  QuickPriceTextField(controller: cubit.priceController),
                  50.h,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: CompanyTextFiled(
                      controller: cubit.nameController,
                      title: 'product_name'.tr(context),
                      hintText: 'enter_product_name'.tr(context),
                    ),
                  ),
                ],
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: CartPrice(
              borderRadius: BorderRadius.zero,
              onTap: () async {
                if (cubit.formKey.currentState!.validate()) {
                  String? brand = await getDeviceBrand();
                  QuickSunmi qSunmi = QuickSunmi();
                  bool isSunmi =
                      brand != null && brand.toUpperCase() == 'SUNMI';
                  cubit.makeQuickBills().then((value) async {
                    if (isSunmi) {
                      cubit
                          .getQuickBill(id: cubit.quickBillsModel!.data!.id!)
                          .then((value) {
                        qSunmi.printReceipt(context);
                      });
                    } else {
                      goToPrintPage(context, cubit);
                    }
                  });
                } else {
                  errorSnackBar(msg: 'please_fill_this_field'.tr(context));
                }
              },
              child: MyText(
                title: 'make_fatora'.tr(context),
                size: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }

  Future<dynamic> goToPrintPage(BuildContext context, QuickPayCubit cubit) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            QuickPrintPage(id: cubit.quickBillsModel!.data!.id!),
      ),
    );
  }
}
