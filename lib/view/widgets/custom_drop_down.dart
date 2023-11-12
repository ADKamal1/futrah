import 'package:flutter/material.dart';
import 'package:futrah/controller/constants/size.dart';
import 'package:futrah/view/widgets/my_text.dart';

class CustomDropDown extends StatelessWidget {
  final String? hintTittle, text;
  final String? dropVal;
  final List<DropdownMenuItem<String>>? source;
  final Color? textColor, dropDownColor;
  final EdgeInsetsGeometry? margin;
  final void Function(String id)? onChanged;

  const CustomDropDown({
    this.hintTittle,
    this.dropVal,
    this.source,
    this.text,
    this.dropDownColor,
    this.textColor,
    this.onChanged,
    super.key,
    this.margin,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      margin: margin ?? const EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText(
            title: (text ?? ''),
            color: textColor ?? Colors.black,
          ),
          6.h,
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
                color: dropDownColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey, width: .5)),
            child: DropdownButton<String>(
              value: dropVal! == '' ? null : dropVal!,
              isExpanded: true,
              hint: MyText(
                title: (hintTittle ?? ''),
                color: Colors.grey[600],
              ),
              underline: Container(),
              onChanged: (v) {
                if (onChanged != null) onChanged!(v!);
              },
              items: source,
            ),
          ),
        ],
      ),
    );
  }
}
