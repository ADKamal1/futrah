// ignore_for_file: use_build_context_synchronously

part of 'pay_imports.dart';

class PayScreen extends StatefulWidget {
  final num totalPrice;
  final List<int> productList;
  final Map idList;
  const PayScreen(
      {super.key,
      required this.totalPrice,
      required this.idList,
      required this.productList});

  @override
  State<PayScreen> createState() => _PayScreenState();
}

class _PayScreenState extends State<PayScreen> {
  Future<bool> _bindingPrinter() async {
    final bool? result = await SunmiPrinter.bindingPrinter();
    return result ?? false;
  }

  bool printBinded = false;
  int paperSize = 0;
  String serialNumber = '';
  String printerVersion = '';
  Future initPrinter() {
    return _bindingPrinter().then((bool isBind) async {
      SunmiPrinter.paperSize().then((int size) {
        setState(() {
          paperSize = size;
        });
      });

      SunmiPrinter.printerVersion().then((String version) {
        setState(() {
          printerVersion = version;
        });
      });

      SunmiPrinter.serialNumber().then((String serial) {
        setState(() {
          serialNumber = serial;
        });
      });

      setState(() {
        printBinded = isBind;
      });
    });
  }

  @override
  void initState() {
    var cubit = PayCubit.get(context);
    cubit.getCustomers();
    cubit.paymentMethod = 1;
    super.initState();
    initPrinter();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PayCubit, PayStates>(
      listener: (context, state) {
        if (state is MakeBillsErrorState) {
          errorSnackBar(msg: 'error'.tr(context));
        }
      },
      builder: (context, state) {
        var cubit = PayCubit.get(context);
        var homeCubit = HomeCubit.get(context);
        num totalPrice() {
          return cubit.getTotalPrice(
            context,
            idList: widget.idList,
            productList: widget.productList,
          );
        }

        return Scaffold(
          appBar: const CustomAppBar(),
          body: CustomCondition(
            state: state is! MakeBillsLoadingState &&
                state is! AddCustomersLoadingState,
            body: ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 20),
              children: [
                const PayHeaderText(),
                20.h,
                PriceRow(totalPrice: '${totalPrice()}'),
                customDivider,
                20.h,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 50,
                      child: CustomDropDown(
                        text: 'select_customer'.tr(context),
                        hintTittle: 'select_customer'.tr(context),
                        dropVal: cubit.selectedCustomer,
                        onChanged: (v) => cubit.chooseCustomer(v),
                        margin: const EdgeInsets.symmetric(horizontal: 25),
                        source: (cubit.getCustomersModel?.data ?? [])
                            .map((e) => DropdownMenuItem(
                                  value: e.id.toString(),
                                  child: Text(e.name ?? ''),
                                ))
                            .toList(),
                      ),
                    ),
                    IconButton(
                      padding: const EdgeInsets.only(top: 25),
                      onPressed: () =>
                          pushNamed(context, route: Routes.customers),
                      icon: const Icon(Icons.add, color: AppColors.green),
                    ),
                  ],
                ),
                20.h,
                Form(
                  key: cubit.formKey,
                  child: Column(
                    children: [
                      const ChoosePaymentMethod(),
                      PrintFatoraCheckbox(
                        onChanged: (val) => cubit.changePrintFatora(val),
                        value: cubit.printFatora,
                      ),
                      AppButton(
                        height: 60,
                        onPressed: cubit.paymentMethod == 0
                            ? () => paymentSnackBar(context)
                            : () async {
                                String? brand = await getDeviceBrand();
                                Sunmi sunmiPrinter = Sunmi();
                                bool isSunmi = brand != null &&
                                    brand.toUpperCase() == 'SUNMI';
                                cubit
                                    .makeBill(idLists: widget.idList)
                                    .then((value) async {
                                  if (cubit.printFatora == true) {
                                    if (isSunmi == true) {
                                      BillsCubit.get(context)
                                          .getSingleBill(
                                              id: cubit
                                                  .makeBillsModel!.data!.id!
                                                  .toInt())
                                          .then((value) {
                                        sunmiPrinter.printReceipt(context);
                                      });
                                    } else {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return PrintPage(
                                              id: cubit
                                                  .makeBillsModel!.data!.id!
                                                  .toInt(),
                                            );
                                          },
                                        ),
                                      );
                                    }
                                  }
                                  homeCubit.clearCart();
                                });
                                if (state is! MakeBillsSuccessState) {
                                  successSnackBar(
                                      msg: 'fatora_created_successfully'
                                          .tr(context));
                                  if (cubit.printFatora == false) {
                                    pushReplacementNamed(context, Routes.home);
                                  }
                                  PayCubit.get(context).printFatora = true;
                                }
                              },
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        color: AppColors.green,
                        child: MyText(
                          title: 'make_fatora'.tr(context),
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // bottomNavigationBar: const QuickPaymentBtn(),
        );
      },
    );
  }

  void paymentSnackBar(BuildContext context) {
    return errorSnackBar(msg: 'please_select_payment_method'.tr(context));
  }
}
