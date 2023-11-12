// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:futrah/controller/constants/size.dart';
import 'package:futrah/controller/resources/theme/colors_manager.dart';
import 'package:futrah/view/screens/profile/cubit/profile_cubit.dart';
import 'package:futrah/view/screens/profile/cubit/profile_states.dart';
import 'package:futrah/view/widgets/custom_app_bar.dart';
import 'package:futrah/view/widgets/custom_condition.dart';
import 'package:futrah/view/widgets/my_text.dart';

class PolicyScreen extends StatefulWidget {
  const PolicyScreen({super.key});

  @override
  State<PolicyScreen> createState() => _PolicyScreenState();
}

class _PolicyScreenState extends State<PolicyScreen> {
  @override
  void initState() {
    ProfileCubit.get(context).getPolicy();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileStates>(
      builder: (context, state) {
        var model = ProfileCubit.get(context).policyModel;
        return Scaffold(
          appBar: const CustomAppBar(),
          body: CustomCondition(
            state: state is! GetPolicyLoadingState && model != null,
            body: MoreProfileBody(model: model),
          ),
        );
      },
    );
  }
}

class MoreProfileBody extends StatelessWidget {
  var model;
  MoreProfileBody({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: model?.data?.length ?? 0,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: [
              MyText(
                title: model?.data?[index].title ?? '',
                alien: TextAlign.start,
                size: 30,
                fontWeight: FontWeight.bold,
              ),
              15.h,
              cDivider(context),
              15.h,
              MyText(
                title: model?.data?[index].content ?? '',
                alien: langAlien(context),
                size: 30,
                maxLines: 1000,
              ),
              15.h,
              cDivider(context),
            ],
          ),
        );
      },
    );
  }
}

Container cDivider(context) {
  return Container(
    height: 2,
    width: MediaQuery.of(context).size.width - 50,
    color: AppColors.grey,
  );
}

TextAlign langAlien(BuildContext context) {
  return Localizations.localeOf(context).languageCode == 'ar'
      ? TextAlign.right
      : TextAlign.left;
}
