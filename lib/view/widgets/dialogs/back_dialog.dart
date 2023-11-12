import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:futrah/controller/resources/localizations/app_localizations.dart';
import 'package:futrah/view/widgets/my_text.dart';

displayDialog(context) async {
  return showCupertinoDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        insetAnimationDuration: const Duration(seconds: 10),
        insetAnimationCurve: Curves.easeInCubic,
        title: MyText(title: 'close_app_title'.tr(context), size: 22),
        content: MyText(title: 'close_app_body'.tr(context), size: 18),
        actions: [
          CupertinoButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: MyText(title: 'cancel'.tr(context)),
          ),
          CupertinoButton(
            onPressed: () => exit(0),
            child: MyText(title: 'exit'.tr(context)),
          ),
        ],
      );
    },
  );
}
