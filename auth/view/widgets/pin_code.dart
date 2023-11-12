import 'package:flutter/material.dart';
import 'package:futrah/controller/constants/pin_theme.dart';
import 'package:futrah/controller/resources/theme/colors_manager.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinCodeFields extends StatelessWidget {
  final void Function(String) onCompleted;
  final TextEditingController? controller;

  const PinCodeFields({super.key, required this.onCompleted, this.controller});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: PinCodeTextField(
        appContext: context,
        controller: controller,
        enablePinAutofill: true,
        length: 6,
        textStyle: const TextStyle(
          color: AppColors.primaryColor,
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
        cursorColor: AppColors.primaryColor,
        keyboardType: TextInputType.number,
        animationType: AnimationType.scale,
        pinTheme: customPinTheme,
        animationDuration: const Duration(milliseconds: 300),
        backgroundColor: Colors.transparent,
        enableActiveFill: true,
        validator: (value) => null,
        onCompleted: (submittedCode) {
          onCompleted(submittedCode);
        },
        onChanged: (value) {},
      ),
    );
  }
}
