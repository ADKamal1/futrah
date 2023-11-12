import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:futrah/controller/constants/strings.dart';
import 'package:futrah/controller/resources/theme/colors_manager.dart';
import 'package:futrah/view/screens/home/cubit/home_cubit.dart';
import 'package:futrah/view/screens/home/cubit/home_states.dart';
import 'package:futrah/view/screens/home/view/widgets/widgets.dart';
import 'package:futrah/view/widgets/my_text.dart';
import 'package:futrah/view/widgets/network_api_img.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeStates>(
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return cubit.categoriesModel!.data!.isEmpty == true
            ? const NoCatAdded()
            : cubit.getProductModel!.data!.isEmpty
                ? const NoProductsAdded()
                : const GridViewBody();
      },
    );
  }
}

class GridViewBody extends StatelessWidget {
  const GridViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeStates>(
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        var model = HomeCubit.get(context).getProductModel;
        return Padding(
          padding: const EdgeInsets.all(10),
          child: GridView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: model?.data?.length ?? 0,
            gridDelegate: gridDelegate,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  if (cubit.idList.containsKey('${model.data![index].id}')) {
                    cubit.idList.remove('${model.data![index].id}');
                    cubit.productList.remove(model.data![index].id);
                    cubit.priceList.remove(model.data![index].price);
                  } else {
                    cubit.idList
                        .putIfAbsent(('${model.data![index].id}'), () => 1);
                    cubit.priceList.add(model.data![index].price!);
                    cubit.productList.add(model.data![index].id!);
                  }
                  cubit.updateList();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color:
                          cubit.idList.containsKey('${model!.data?[index].id}')
                              ? AppColors.green
                              : Colors.transparent,
                      width: 2,
                    ),
                    boxShadow: boxShadow,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AppNetworkImage(
                        url: '${model.data?[index].image?.path}',
                        fit: BoxFit.fill,
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FittedBox(
                              child: MyText(
                                title: '${model.data?[index].title}',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            FittedBox(
                              child: MyText(
                                title:
                                    '${model.data?[index].price} ${AppStrings.currency}',
                                size: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
