import 'package:flutter/material.dart';
import 'package:futrah/controller/resources/localizations/app_localizations.dart';
import 'package:futrah/controller/resources/theme/colors_manager.dart';
import 'package:futrah/view/screens/auth/view/widgets/auth_logo.dart';

class OtpHeader extends StatelessWidget {
  final String phone;
  const OtpHeader({super.key, required this.phone});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AuthLogo(height: 200, width: 200),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: 'otp_send'.tr(context),
            style: const TextStyle(
              color: AppColors.primaryColor,
              fontSize: 18,
            ),
            children: <TextSpan>[
              TextSpan(
                text: '$phone ',
                style: const TextStyle(
                  color: AppColors.green,
                  fontSize: 18,
                ),
              ),
              TextSpan(
                text: 'otp_send2'.tr(context),
                style: const TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
