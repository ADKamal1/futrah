import 'package:flutter/material.dart';
import 'package:futrah/controller/resources/theme/colors_manager.dart';

class MyText extends StatelessWidget {
  final String title;
  final Color? color;
  final double? size;
  final double? letterSpace;
  final double? wordSpace;
  final String? fontFamily;
  final int? maxLines;
  final TextAlign? alien;
  final TextDecoration? decoration;
  final TextOverflow? overflow;
  final FontWeight? fontWeight;
  final TextStyle? style;

  const MyText({
    super.key,
    required this.title,
    this.size,
    this.color,
    this.style,
    this.alien,
    this.fontFamily,
    this.decoration,
    this.letterSpace,
    this.wordSpace,
    this.overflow,
    this.fontWeight,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: alien ?? TextAlign.start,
      overflow: overflow ?? TextOverflow.ellipsis,
      maxLines: maxLines,
      style: style ??
          TextStyle(
            color: color ?? AppColors.primaryColor,
            fontSize: size ?? 16,
            decoration: decoration ?? TextDecoration.none,
            fontWeight: fontWeight,
            fontFamily: fontFamily ?? 'Ubuntu',
          ),
    );
  }
}
