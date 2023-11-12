import 'package:flutter/material.dart';
import 'package:futrah/controller/resources/theme/colors_manager.dart';
import 'package:futrah/view/widgets/my_text.dart';

class ProfileItem extends StatelessWidget {
  final String title;
  final Function() onTap;

  const ProfileItem({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: onTap,
              child: Row(
                children: [
                  MyText(
                    title: title,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 3,
            width: MediaQuery.of(context).size.width - 50,
            color: AppColors.grey,
          ),
        ],
      ),
    );
  }
}
