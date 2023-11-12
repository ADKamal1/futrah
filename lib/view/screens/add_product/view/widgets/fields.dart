import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:futrah/controller/constants/size.dart';
import 'package:futrah/controller/resources/localizations/app_localizations.dart';
import 'package:futrah/view/screens/add_category/cubit/category_cubit.dart';
import 'package:futrah/view/screens/add_category/cubit/category_state.dart';
import 'package:futrah/view/screens/add_product/cubit/product_cubit.dart';
import 'package:futrah/view/screens/add_product/cubit/product_state.dart';
import 'package:futrah/view/screens/auth/view/widgets/company_login_filed.dart';
import 'package:futrah/view/widgets/custom_drop_down.dart';

class AddProductColumnFields extends StatelessWidget {
  const AddProductColumnFields({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        var cubit = ProductCubit.get(context);
        var categoryCubit = CategoryCubit.get(context);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              CompanyTextFiled(
                controller: cubit.productName,
                title: 'product_name'.tr(context),
                hintText: 'enter_product_name'.tr(context),
              ),
              5.h,
              CompanyTextFiled(
                controller: cubit.productOptionalPrice,
                validate: false,
                title: 'buy_price'.tr(context),
                hintText: 'buy_price2'.tr(context),
                keyboardType: TextInputType.number,
              ),
              5.h,
              CompanyTextFiled(
                controller: cubit.productPrice,
                keyboardType: TextInputType.number,
                title: 'sell_price'.tr(context),
                hintText: 'company_tax_number_hint'.tr(context),
              ),
              5.h,
              BlocBuilder<CategoryCubit, CategoryState>(
                builder: (context, state) {
                  return CustomDropDown(
                    text: 'select_cat'.tr(context),
                    hintTittle: 'select_cat'.tr(context),
                    dropVal: cubit.selectedCategory,
                    onChanged: (v) => cubit.chooseCategory(v),
                    source: (categoryCubit.getCategoriesModel?.data ?? [])
                        .map((e) => DropdownMenuItem(
                              value: e.id.toString(),
                              child: Text(e.title ?? ''),
                            ))
                        .toList(),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
