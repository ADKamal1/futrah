// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:futrah/controller/integration/bluetooth/print_page.dart';
import 'package:futrah/controller/integration/bluetooth/sunmi.dart';
import 'package:futrah/controller/resources/localizations/app_localizations.dart';
import 'package:futrah/controller/resources/theme/colors_manager.dart';
import 'package:futrah/controller/services/helpers/get_device_brand.dart';
import 'package:futrah/view/screens/bills/cubit/bills_cubit.dart';
import 'package:futrah/view/screens/bills/cubit/bills_state.dart';
import 'package:futrah/view/screens/bills/view/bills_imports.dart';
import 'package:futrah/view/screens/home/view/widgets/no_products.dart';
import 'package:futrah/view/widgets/my_text.dart';

class BillsListItem extends StatelessWidget {
  const BillsListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BillsCubit, BillsState>(
      builder: (BuildContext context, state) {
        var getAllBills = BillsCubit.get(context).getAllBillsModel;
        var cubit = BillsCubit.get(context);
        return getAllBills?.data?.isNotEmpty == false
            ? const NoData(title: 'no_bills')
            : Container(
                height: 450,
                decoration: buildBoxDecoration,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  itemCount: getAllBills?.data?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    int billId = getAllBills?.data?[index].id ?? 0;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.75,
                            height: 60,
                            color: AppColors.primaryColor,
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MyText(
                                  title:
                                      "${'bill_number'.tr(context)} # $billId",
                                  color: Colors.white,
                                  size: 20,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            SingleBillScreen(id: billId),
                                      ),
                                    );
                                  },
                                  child: MyText(
                                    title: 'show'.tr(context),
                                    color: Colors.white,
                                    size: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              cubit.getSingleBill(id: billId);
                              String? brand = await getDeviceBrand();
                              Sunmi printer = Sunmi();
                              bool isSunmi = brand != null &&
                                  brand.toUpperCase() == 'SUNMI';
                              if (isSunmi == true) {
                                BillsCubit.get(context)
                                    .getSingleBill(
                                        id: cubit.makeBillsModel!.data!.id!
                                            .toInt())
                                    .then((value) {
                                  printer.printReceipt(context);
                                });
                              } else {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => PrintPage(id: billId),
                                  ),
                                );
                              }
                            },
                            icon: const Icon(
                              Icons.print_outlined,
                              size: 30,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
      },
    );
  }
}

BoxDecoration get buildBoxDecoration =>
    BoxDecoration(border: Border.all(color: AppColors.primaryColor));
