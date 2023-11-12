import 'package:flutter/material.dart';
import 'package:futrah/controller/constants/size.dart';
import 'package:futrah/controller/resources/localizations/app_localizations.dart';
import 'package:futrah/view/screens/pay/view/widgets/payment_card.dart';
import 'package:futrah/view/widgets/my_text.dart';

class ChoosePaymentMethod extends StatelessWidget {
  const ChoosePaymentMethod({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Row(
            children: [
              MyText(title: 'payment_method'.tr(context), size: 16),
            ],
          ),
        ),
        20.h,
        const PaymentCardRow(),
        20.h,
      ],
    );
  }
}
