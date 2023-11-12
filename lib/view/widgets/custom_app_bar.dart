import 'package:flutter/material.dart';
import 'package:futrah/controller/constants/change_lang.dart';
import 'package:futrah/controller/resources/theme/colors_manager.dart';

class CustomAppBar extends StatelessWidget implements PreferredSize {
  final Widget? leading, title;
  final bool? hideNotification, isLeading;
  final Color? backgroundColor;
  final double? elevation, height;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;

  const CustomAppBar({
    super.key,
    this.leading,
    this.title,
    this.hideNotification,
    this.backgroundColor,
    this.elevation,
    this.actions,
    this.height,
    this.isLeading = true,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? AppColors.white,
      automaticallyImplyLeading: isLeading ?? false,
      elevation: elevation ?? 0,
      centerTitle: true,
      title: title ?? Image.asset(langLogo(context), width: 110, height: 110),
      actions: actions,
      leading: leading,
      bottom: bottom,
    );
  }

  @override
  Widget get child => const CustomAppBar();

  @override
  Size get preferredSize => Size.fromHeight(height ?? 70);
}
