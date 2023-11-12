import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:futrah/view/screens/profile/cubit/profile_cubit.dart';
import 'package:futrah/view/screens/profile/cubit/profile_states.dart';
import 'package:futrah/view/screens/profile/view/profile_views/accept_terms_conditions.dart';
import 'package:futrah/view/widgets/custom_app_bar.dart';
import 'package:futrah/view/widgets/custom_condition.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  void initState() {
    ProfileCubit.get(context).getAboutUs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileStates>(
      builder: (context, state) {
        var model = ProfileCubit.get(context).aboutUsModel;
        return Scaffold(
          appBar: const CustomAppBar(),
          body: CustomCondition(
            state: state is! GetAboutUsLoadingState && model != null,
            body: MoreProfileBody(model: model),
          ),
        );
      },
    );
  }
}
