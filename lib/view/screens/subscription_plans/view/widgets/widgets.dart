// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:futrah/controller/resources/localizations/app_localizations.dart';
import 'package:futrah/controller/resources/theme/colors_manager.dart';
import 'package:futrah/view/screens/subscription_plans/cubit/subscription_cubit.dart';
import 'package:futrah/view/screens/subscription_plans/cubit/subscription_state.dart';
import 'package:futrah/view/widgets/custom_condition.dart';
import 'package:futrah/view/widgets/my_text.dart';

class PlansCard extends StatelessWidget {
  const PlansCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubscriptionCubit, SubscriptionState>(
      builder: (context, state) {
        var cubit = SubscriptionCubit.get(context);
        var model = cubit.subscriptionModel;
        var data = model?.data;
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          child: CustomCondition(
            state: state is! GetSubscriptionLoadingState,
            body: GridView.builder(
              itemCount: data?.length ?? 0,
              gridDelegate: gridDelegate,
              itemBuilder: (context, index) {
                return PlansCard2(
                  onTap: () {
                    cubit.selectedPlanMethod(
                      id: data[index].id!.toInt(),
                      index: index,
                    );
                  },
                  index: index,
                  id: data?[index].id ?? 0,
                  color: cubit.selectedPlanId == data![index].id
                      ? AppColors.green
                      : AppColors.white,
                  textColor: cubit.selectedPlanId == data[index].id
                      ? Colors.white
                      : AppColors.primaryColor,
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class PlansCard2 extends StatelessWidget {
  final void Function() onTap;
  final int id;
  final int index;
  final Color color;
  final Color textColor;

  const PlansCard2({
    super.key,
    required this.onTap,
    required this.id,
    required this.index,
    required this.color,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubscriptionCubit, SubscriptionState>(
      builder: (context, state) {
        var cubit = SubscriptionCubit.get(context).subscriptionModel;
        return GestureDetector(
          onTap: onTap,
          child: Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2.5,
                  blurRadius: 3.5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MyText(
                  title: '${cubit?.data![index].days} ${'days'.tr(context)}',
                  alien: TextAlign.center,
                  size: 20,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
                FittedBox(
                  child: MyText(
                    title: '${cubit?.data![index].price}\n${'sar'.tr(context)}',
                    size: 27,
                    alien: TextAlign.center,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                MyText(
                  title: '${cubit?.data![index].name}',
                  size: 27,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

SliverGridDelegateWithFixedCrossAxisCount get gridDelegate {
  return const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    mainAxisSpacing: 0,
    crossAxisSpacing: 0,
    childAspectRatio: 0.8,
  );
}
