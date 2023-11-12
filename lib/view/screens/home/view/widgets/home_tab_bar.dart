import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:futrah/controller/resources/localizations/app_localizations.dart';
import 'package:futrah/controller/resources/theme/colors_manager.dart';
import 'package:futrah/view/screens/home/cubit/home_cubit.dart';
import 'package:futrah/view/screens/home/cubit/home_states.dart';
import 'package:futrah/view/widgets/my_text.dart';

class HomeTabBar extends StatelessWidget implements PreferredSize {
  const HomeTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeStates>(
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Container(
          height: 40,
          width: double.infinity,
          color: AppColors.primaryColor,
          child: cubit.categoriesModel!.data!.isEmpty == true
              ? Center(
                  child: MyText(
                    title: 'no_category_added'.tr(context),
                    color: Colors.white,
                  ),
                )
              : ListView.builder(
                  itemCount: cubit.categoriesModel?.data?.length ?? 0,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () => cubit.getProduct(index: index),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: Center(
                          child: MyText(
                            title:
                                cubit.categoriesModel?.data?[index].title ?? '',
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                    );
                  },
                ),
        );
      },
    );
  }

  @override
  Widget get child => const HomeTabBar();

  @override
  Size get preferredSize => const Size.fromHeight(40);
}
