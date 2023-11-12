import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:futrah/controller/constants/app_images.dart';
import 'package:futrah/controller/resources/theme/colors_manager.dart';
import 'package:futrah/view/screens/pay/cubit/pay_cubit.dart';
import 'package:futrah/view/screens/pay/cubit/pay_states.dart';
import 'package:futrah/view/widgets/my_text.dart';

class PriceRow extends StatelessWidget {
  final String totalPrice;

  const PriceRow({super.key, required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PayCubit, PayStates>(
      builder: (context, state) {
        var cubit = PayCubit.get(context);
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Icon(Icons.abc, color: Colors.transparent),
            MyText(
              title: 'SAR $totalPrice',
              color: AppColors.green,
              size: 20,
              fontWeight: FontWeight.bold,
            ),
            IconButton(
              padding: EdgeInsets.zero,
              onPressed: () => cubit.copyMethod(context, totalPrice),
              icon: Image.asset(AppImages.copy),
            ),
          ],
        );
      },
    );
  }
}
