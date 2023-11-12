import 'package:flutter/material.dart';
import 'package:futrah/controller/constants/size.dart';
import 'package:futrah/controller/constants/strings.dart';
import 'package:futrah/controller/resources/localizations/app_localizations.dart';
import 'package:futrah/controller/resources/theme/colors_manager.dart';
import 'package:futrah/view/widgets/cancel_button.dart';
import 'package:futrah/view/widgets/my_text.dart';

class CartPrice extends StatelessWidget {
  final String? title;
  final Function onTap;
  final EdgeInsets? margin;
  final Widget? child;
  final BorderRadius? borderRadius;

  const CartPrice({
    super.key,
    this.title,
    required this.onTap,
    this.margin,
    this.child,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return AppButton(
      height: 60,
      onPressed: onTap,
      width: MediaQuery.of(context).size.width,
      margin: margin ?? const EdgeInsets.symmetric(horizontal: 20),
      color: AppColors.green,
      borderRadius: borderRadius,
      child: child ??
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyText(title: 'advance_to_pay'.tr(context), color: Colors.white),
              5.w,
              Row(
                children: [
                  const Icon(Icons.shopping_cart, color: Colors.white),
                  10.w,
                  MyText(title: title ?? '', color: Colors.white),
                  10.w,
                  const MyText(title: AppStrings.currency, color: Colors.white),
                ],
              ),
            ],
          ),
    );
  }
}
