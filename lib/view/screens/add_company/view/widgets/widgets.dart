import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:futrah/controller/resources/theme/colors_manager.dart';
import 'package:futrah/view/screens/add_company/cubit/company_cubit.dart';
import 'package:futrah/view/screens/add_company/cubit/company_state.dart';

class CompanyPickImage extends StatelessWidget {
  const CompanyPickImage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompanyCubit, CompanyState>(
      builder: (context, state) {
        var cubit = CompanyCubit.get(context);
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
