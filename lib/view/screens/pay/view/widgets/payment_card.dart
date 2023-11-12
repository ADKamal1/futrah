import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:futrah/controller/constants/app_images.dart';
import 'package:futrah/controller/resources/theme/colors_manager.dart';
import 'package:futrah/view/screens/pay/cubit/pay_cubit.dart';
import 'package:futrah/view/screens/pay/cubit/pay_states.dart';

class PaymentCard extends StatelessWidget {
  final String img;
  final Color? color;
  final void Function() onTap;
  final int id;
  final Color borderColor;

  const PaymentCard({
    super.key,
    required this.id,
    required this.img,
    required this.onTap,
    this.color,
    required this.borderColor,
  });
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width * 0.3;
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 7,
        child: Container(
          width: width,
          height: 115,
          decoration: BoxDecoration(
            color: color ?? Colors.transparent,
            border: Border.all(color: borderColor, width: 3),
          ),
          child: Center(child: Image.asset(img)),
        ),
      ),
    );
  }
}

class PaymentCardRow extends StatelessWidget {
  const PaymentCardRow({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PayCubit, PayStates>(
      builder: (context, state) {
        var cubit = PayCubit.get(context);
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            PaymentCard(
              id: 1,
              img: AppImages.cache,
              color: AppColors.green,
              onTap: () => cubit.changePaymentMethod(id: 1),
              borderColor:
                  cubit.paymentMethod == 1 ? AppColors.red : Colors.transparent,
            ),
            PaymentCard(
              id: 2,
              img: AppImages.visa,
              color: AppColors.darkBlue,
              onTap: () => cubit.changePaymentMethod(id: 2),
              borderColor:
                  cubit.paymentMethod == 2 ? AppColors.red : Colors.transparent,
            ),
            PaymentCard(
              id: 3,
              img: AppImages.mada,
              onTap: () => cubit.changePaymentMethod(id: 3),
              borderColor:
                  cubit.paymentMethod == 3 ? AppColors.red : Colors.transparent,
            ),
          ],
        );
      },
    );
  }
}
