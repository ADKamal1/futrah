import 'package:flutter/material.dart';
import 'package:futrah/controller/constants/strings.dart';

class AppNetworkImage extends StatelessWidget {
  final String? url;
  final double? width, height;
  final BoxFit? fit;
  const AppNetworkImage(
      {super.key, required this.url, this.width, this.height, this.fit});
  @override
  Widget build(BuildContext context) {
    String baseUrl = '${AppStrings.baseUrl}/$url';
    return Image.network(
      url != null ? baseUrl : AppStrings.placeholder,
      fit: fit ?? BoxFit.cover,
      height: height ?? 100,
      width: width ?? 100,
    );
  }
}
