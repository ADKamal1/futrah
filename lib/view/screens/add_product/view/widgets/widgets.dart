import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:futrah/controller/constants/size.dart';
import 'package:futrah/controller/resources/localizations/app_localizations.dart';
import 'package:futrah/controller/resources/theme/colors_manager.dart';
import 'package:futrah/view/screens/add_product/cubit/product_cubit.dart';
import 'package:futrah/view/screens/add_product/cubit/product_state.dart';
import 'package:futrah/view/widgets/my_text.dart';

class IsTax extends StatelessWidget {
  final String title;
  final Function(bool) onChanged;
  final bool value;

  const IsTax({
    super.key,
    required this.title,
    required this.onChanged,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: (val) {
            onChanged(val!);
          },
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          activeColor: AppColors.green,
        ),
        MyText(title: title),
      ],
    );
  }
}

class TaxRow extends StatelessWidget {
  const TaxRow({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        var cubit = ProductCubit.get(context);
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IsTax(
              title: 'with_tax'.tr(context),
              value: cubit.withTax,
              onChanged: (val) => cubit.chooseTax(val, 0),
            ),
            20.w,
            IsTax(
              title: 'without_tax'.tr(context),
              value: cubit.withoutTax,
              onChanged: (val) => cubit.chooseTax(val, 1),
            ),
          ],
        );
      },
    );
  }
}

class ProductPickImage extends StatelessWidget {
  const ProductPickImage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        var cubit = ProductCubit.get(context);
        return InkWell(
          onTap: () => cubit.chooseImage(),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Container(
              width: 130,
              height: 130,
              decoration: const BoxDecoration(color: AppColors.white),
              child: cubit.image.path == ''
                  ? const Icon(
                      Icons.add_a_photo_outlined,
                      size: 60,
                      color: AppColors.primaryColor,
                    )
                  : Image.file(cubit.image, fit: BoxFit.cover),
            ),
          ),
        );
      },
    );
  }
}
