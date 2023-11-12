import 'package:flutter/material.dart';
import 'package:futrah/controller/resources/theme/colors_manager.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

PinTheme customPinTheme = PinTheme(
  shape: PinCodeFieldShape.box,
  borderRadius: BorderRadius.circular(5),
  fieldHeight: 50,
  fieldWidth: 40,
  borderWidth: 3,
  disabledColor: AppColors.white,
  selectedColor: AppColors.white,
  activeColor: AppColors.white,
  inactiveColor: AppColors.white,
  inactiveFillColor: AppColors.white,
  activeFillColor: AppColors.white,
  selectedFillColor: AppColors.white,
);
