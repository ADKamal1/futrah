import 'package:flutter/material.dart';
import 'package:futrah/controller/constants/app_images.dart';
import 'package:futrah/controller/constants/size.dart';
import 'package:futrah/view/widgets/my_text.dart';

customErrorScreen() {
  return ErrorWidget.builder = ((details) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.black87,
        child: Center(
          child: Column(
            children: [
              Image.asset(AppImages.logo, width: 200, height: 200),
              20.h,
              MyText(
                title: details.exception.toString(),
                color: Colors.white,
                alien: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  });
}
