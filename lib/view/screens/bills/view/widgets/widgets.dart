import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:futrah/controller/resources/localizations/app_localizations.dart';
import 'package:futrah/controller/resources/theme/colors_manager.dart';
import 'package:futrah/view/screens/bills/cubit/bills_cubit.dart';
import 'package:futrah/view/screens/bills/cubit/bills_state.dart';
import 'package:futrah/view/widgets/my_text.dart';

class TotalBills extends StatelessWidget {
  const TotalBills({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BillsCubit, BillsState>(
      builder: (context, state) {
        var cubit = BillsCubit.get(context).getAllBillsModel;
        return Column(
          children: [
            TotalBillsRow(
              title1: 'all_bills_price'.tr(context),
              title2: '${cubit?.billsTotalAmount ?? '0'}',
            ),
            const Divider(color: AppColors.primaryColor, thickness: 1),
            TotalBillsRow(
              title1: 'all_bills_tax'.tr(context),
              title2: '${cubit?.totalTaxAmount ?? '0'}',
            ),
            const Divider(color: AppColors.primaryColor, thickness: 1),
            TotalBillsRow(
              title1: 'net_bills_price'.tr(context),
              title2: '${cubit?.totalNetAmount ?? '0'}',
            ),
          ],
        );
      },
    );
  }
}

class TotalBillsRow extends StatelessWidget {
  final String title1;
  final String title2;

  const TotalBillsRow({super.key, required this.title1, required this.title2});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        MyText(
          title: title1,
          size: 20,
          fontWeight: FontWeight.bold,
        ),
        const Spacer(),
        MyText(
          title: title2,
          size: 20,
          alien: TextAlign.center,
          color: AppColors.green,
          fontWeight: FontWeight.bold,
        ),
      ],
    );
  }
}

class PayHeaderText extends StatelessWidget {
  const PayHeaderText({super.key});

  @override
  Widget build(BuildContext context) {
    return MyText(
      title: 'total_price'.tr(context),
      alien: TextAlign.center,
      size: 20,
      fontWeight: FontWeight.bold,
    );
  }
}

Container get customDivider {
  return Container(
    color: AppColors.grey,
    width: double.infinity,
    height: 1,
    margin: const EdgeInsets.symmetric(horizontal: 20),
  );
}
