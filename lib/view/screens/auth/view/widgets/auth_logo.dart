import 'package:flutter/material.dart';
import 'package:futrah/controller/constants/change_lang.dart';

class AuthLogo extends StatelessWidget {
  final double? width, height;
  final String? img;

  const AuthLogo({super.key, this.width, this.height, this.img});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        img ?? langLogo(context),
        width: width ?? 300,
        height: height ?? 300,
      ),
    );
  }
}
