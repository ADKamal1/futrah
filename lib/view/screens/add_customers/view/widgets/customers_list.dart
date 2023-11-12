import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:futrah/controller/resources/localizations/app_localizations.dart';
import 'package:futrah/controller/resources/theme/colors_manager.dart';
import 'package:futrah/view/screens/add_customers/cubit/customers_cubit.dart';
import 'package:futrah/view/screens/add_customers/cubit/customers_state.dart';
import 'package:futrah/view/screens/home/view/widgets/no_products.dart';
import 'package:futrah/view/widgets/custom_condition.dart';
import 'package:futrah/view/widgets/custom_loading.dart';
import 'package:futrah/view/widgets/my_text.dart';

class CustomersListItem extends StatelessWidget {
  const CustomersListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomersCubit, CustomersState>(
      builder: (BuildContext context, state) {
        var cubit = CustomersCubit.get(context);
        var model = cubit.getCustomersModel;
        return CustomCondition(
          state: state is! GetCustomersLoadingState,
          loading: const OverlayLoading(height: 250),
          body: model?.data?.isNotEmpty == false
              ? NoData(title: 'no_customers'.tr(context))
              : Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  decoration: buildBoxDecoration,
                  child: ListView.builder(
                    shrinkWrap: true,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    itemCount: model?.data?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      int itemCount = model?.data?.length ?? 0;
                      int reversedIndex = itemCount - 1 - index;
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.75,
                              height: 60,
                              color: AppColors.primaryColor,
                              padding: const EdgeInsets.all(10),
                              child: MyText(
                                title: model?.data?[reversedIndex].name ?? '',
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                cubit.deleteCustomers(
                                  id: model?.data?[reversedIndex].id ?? 0,
                                );
                              },
                              icon: const Icon(Icons.delete_outline, size: 30),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
        );
      },
    );
  }

  BoxDecoration get buildBoxDecoration {
    return BoxDecoration(
      border: Border.all(color: AppColors.primaryColor),
    );
  }
}
