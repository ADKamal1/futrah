import 'package:flutter/material.dart';
import 'package:futrah/controller/resources/theme/colors_manager.dart';

class AppLoading extends StatelessWidget {
  final double? size;
  const AppLoading({super.key, this.size});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: const Center(
        child: CircularProgressIndicator(color: AppColors.primaryColor),
      ),
    );
  }
}

class OverlayLoading extends StatelessWidget {
  final double? height;

  const OverlayLoading({super.key, this.height});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 400,
      child: const AppLoading(),
    );
  }
}
