import 'package:flutter/material.dart';
import 'package:futrah/controller/resources/localizations/app_localizations.dart';
import 'package:futrah/controller/resources/theme/colors_manager.dart';
import 'package:futrah/view/widgets/my_text.dart';

class PrintFatoraCheckbox extends StatelessWidget {
  final Function(bool) onChanged;
  final bool value;

  const PrintFatoraCheckbox(
      {super.key, required this.onChanged, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: (val) => onChanged(val!),
          activeColor: AppColors.green,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        MyText(
          title: 'print_fatora'.tr(context),
          fontWeight: FontWeight.bold,
        ),
      ],
    );
  }
}
