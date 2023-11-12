import 'package:flutter/material.dart';
import 'package:futrah/controller/constants/app_images.dart';
import 'package:futrah/controller/resources/localizations/app_localizations.dart';
import 'package:futrah/controller/resources/theme/colors_manager.dart';
import 'package:futrah/controller/routes/app_router_imports.dart';
import 'package:futrah/view/widgets/my_text.dart';

class QuickPaymentBtn extends StatelessWidget {
  const QuickPaymentBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => pushNamed(context, route: Routes.quickPayment),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        minimumSize: const Size(double.infinity, 70),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MyText(title: 'quick_payment'.tr(context), color: Colors.white),
          Image.asset(AppImages.quickInvoice),
        ],
      ),
    );
  }
}
