import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:futrah/controller/resources/theme/colors_manager.dart';
import 'package:futrah/view/screens/profile/cubit/profile_cubit.dart';
import 'package:futrah/view/screens/profile/cubit/profile_states.dart';
import 'package:futrah/view/widgets/network_api_img.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileStates>(
      builder: (context, state) {
        var model = ProfileCubit.get(context).userModel?.data;
        return Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          color: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          child: AppNetworkImage(
            url: model?.attachmentRelation?.path,
            width: 172,
            height: 172,
          ),
        );
      },
    );
  }
}

class UploadImage extends StatelessWidget {
  const UploadImage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileStates>(
      builder: (context, state) {
        var cubit = ProfileCubit.get(context);
        return InkWell(
          onTap: () => cubit.chooseImage(),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Container(
              width: 130,
              height: 130,
              decoration: const BoxDecoration(color: AppColors.white),
              child: cubit.image == null
                  ? const Icon(
                      Icons.add_a_photo_outlined,
                      size: 60,
                      color: AppColors.primaryColor,
                    )
                  : Image.file(cubit.image!, fit: BoxFit.cover),
            ),
          ),
        );
      },
    );
  }
}
