import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:futrah/controller/constants/size.dart';
import 'package:futrah/controller/resources/localizations/app_localizations.dart';
import 'package:futrah/controller/resources/theme/colors_manager.dart';
import 'package:futrah/view/widgets/my_text.dart';

class LoginTextFiled extends StatelessWidget {
  final TextEditingController? controller;
  final Function(void)? onSubmit;
  final Function(String) onChanged;

  const LoginTextFiled(
      {super.key, this.controller, this.onSubmit, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return
      Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              MyText(title: 'phone_number'.tr(context), size: 16),
            ],
          ),
          5.h,
          Directionality(
            textDirection: TextDirection.ltr,
            child:
            TextFormField(
              textDirection: TextDirection.ltr,
              controller: controller,
              autofocus: true,
              keyboardType: TextInputType.phone,
              cursorColor: Colors.black,
              style: const TextStyle(
                fontSize: 18,
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w800,
              ),
              decoration: inputDecoration(
                prefixIcon: CountryCodePicker(
                  onChanged: (value) => onChanged(value.dialCode!),
                  initialSelection: '+966',
                  favorite: const ['+966', 'SA'],
                  showCountryOnly: true,
                  showOnlyCountryWhenClosed: false,
                  alignLeft: false,
                ),
              ),
              // validator: (String? value) {
              //   if (value!.isEmpty) {
              //     return 'phone_number_required'.tr(context);
              //   } else if (value.length < 9) {
              //     return 'phone_number_smaller'.tr(context);
              //   } else if (value.length > 9) {
              //     return 'phone_number_bigger'.tr(context);
              //   }
              //   return null;
              // },
              onFieldSubmitted: (value) => onSubmit!(value),
            ),
          ),
        ],
      ),
    );
  }
}

InputDecoration inputDecoration({required Widget prefixIcon}) {
  return InputDecoration(
    border: outlineBorder,
    focusedBorder: outlineBorder,
    enabledBorder: outlineBorder,
    filled: true,
    fillColor: AppColors.white,
    prefixIcon: prefixIcon,
  );
}

OutlineInputBorder get outlineBorder => const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent, width: 2),
    );


class AuthTextFiled extends StatelessWidget {
  final TextEditingController? controller;
  final String title;
  final IconData? prefix;
  final IconData? suffix;
  final void Function()? suffixPressed;
  final TextInputType? keyboardType;
  final bool isPassword;
  final String? Function(String?)? validator;
  final void Function(String)? onSubmitted;

  const AuthTextFiled({
    super.key,
    this.controller,
    required this.title,
    this.suffixPressed,
    this.keyboardType,
    required this.isPassword,
    this.prefix,
    this.suffix,
    this.validator,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              MyText(title: title, size: 16),
            ],
          ),
          5.h,
          Directionality(
            textDirection: TextDirection.ltr,
            child: TextFormField(
              validator: validator,
              textDirection: TextDirection.ltr,
              controller: controller,
              autofocus: true,
              obscureText: isPassword,
              keyboardType: keyboardType,
              cursorColor: Colors.black,
              onFieldSubmitted: (value) => onSubmitted!(value),
              style: const TextStyle(
                fontSize: 18,
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w800,
              ),
              decoration: InputDecoration(
                border: outlineBorder,
                focusedBorder: outlineBorder,
                enabledBorder: outlineBorder,
                filled: true,
                fillColor: AppColors.white,
                prefixIcon: Icon(prefix, color: AppColors.primaryColor),
                suffixIcon: suffix != null
                    ? IconButton(
                  onPressed: suffixPressed,
                  icon: Icon(suffix, color: AppColors.primaryColor),
                )
                    : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

