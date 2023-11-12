import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:futrah/controller/constants/size.dart';
import 'package:futrah/controller/resources/localizations/app_localizations.dart';
import 'package:futrah/view/screens/add_category/view/widgets/add_category_filed.dart';
import 'package:futrah/view/screens/add_customers/cubit/customers_cubit.dart';
import 'package:futrah/view/screens/add_customers/cubit/customers_state.dart';

class TextFiledPart extends StatelessWidget {
  const TextFiledPart({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomersCubit, CustomersState>(
      builder: (context, state) {
        var cubit = CustomersCubit.get(context);
        return Column(
          children: [
            AddCategoryTextFiled(
              controller: cubit.customersName,
              hintText: 'enter_customer_name'.tr(context),
              title: 'customer_name'.tr(context),
              suffixIcon: Icons.person,
            ),
            10.h,
            AddCategoryTextFiled(
              controller: cubit.customersPhone,
              hintText: 'enter_phone_number'.tr(context),
              title: 'phone_number'.tr(context),
              suffixIcon: Icons.phone_iphone,
              keyboardType: TextInputType.phone,
            ),
            10.h,
            AddCategoryTextFiled(
              controller: cubit.taxNumber,
              title: 'customer_tax_number'.tr(context),
              hintText: '',
              suffixIcon: Icons.phone_iphone,
            ),
          ],
        );
      },
    );
  }
}
