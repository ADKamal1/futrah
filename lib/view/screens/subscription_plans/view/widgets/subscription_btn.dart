part of '../subscription_import.dart';

class SubscriptionBtn extends StatelessWidget {
  final Function? onTap;

  const SubscriptionBtn({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return AppButton(
      height: 60,
      onPressed: onTap,
      text: 'go_to_payment'.tr(context),
      fontSize: 20,
      margin: const EdgeInsets.symmetric(vertical: 10),
      borderRadius: BorderRadius.circular(6),
      color: AppColors.green,
    );
  }
}

class SubscriptionTextField extends StatelessWidget {
  final TextEditingController controller;

  const SubscriptionTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            MyText(title: 'enter_card_number_o'.tr(context), size: 20),
          ],
        ),
        TextFormField(
          controller: controller,
          textAlignVertical: TextAlignVertical.center,
          textAlign: TextAlign.start,
          keyboardType: TextInputType.number,
          style: const TextStyle(color: AppColors.primaryColor, fontSize: 20),
          validator: (value) {
            if (value!.isEmpty) {
              return 'please_fill_this_field'.tr(context);
            } else if (value.length > 4) {
              return 'min_number_is_4'.tr(context);
            } else if (value.length < 50) {
              return 'max_number_is_50'.tr(context);
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: 'enter_card_number'.tr(context),
            hintStyle:
                const TextStyle(color: AppColors.primaryColor, fontSize: 20),
            fillColor: AppColors.white,
            filled: true,
            enabledBorder: underlineBorder,
            focusedBorder: underlineBorder,
            border: underlineBorder,
          ),
        ),
      ],
    );
  }

  UnderlineInputBorder get underlineBorder {
    return const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent));
  }
}
