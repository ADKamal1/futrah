import 'package:flutter/material.dart';
import 'package:futrah/controller/resources/localizations/app_localizations.dart';
import 'package:futrah/controller/routes/app_router_imports.dart';
import 'package:futrah/view/screens/home/view/widgets/no_products.dart';
import 'package:futrah/view/widgets/my_text.dart';

class NoCatAdded extends StatelessWidget {
  const NoCatAdded({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        NoData(title: 'no_category_added'.tr(context), height: 100),
        ElevatedButton(
          child: MyText(
            title: 'add_categories'.tr(context),
            color: Colors.white,
          ),
          onPressed: () => pushNamed(context, route: Routes.category),
        ),
      ],
    );
  }
}

class NoProductsAdded extends StatelessWidget {
  const NoProductsAdded({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const NoData(height: 100),
        ElevatedButton(
          child: MyText(
              title: 'please_add_product'.tr(context), color: Colors.white),
          onPressed: () => pushNamed(context, route: Routes.addProduct),
        ),
      ],
    );
  }
}

List<BoxShadow> get boxShadow {
  return const [
    BoxShadow(
      color: Colors.grey,
      spreadRadius: 1.5,
      blurRadius: 2.5,
      offset: Offset(0, 1.5),
    ),
  ];
}

SliverGridDelegateWithFixedCrossAxisCount get gridDelegate {
  return const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 3,
    mainAxisSpacing: 10,
    crossAxisSpacing: 10,
    childAspectRatio: 0.7,
  );
}
