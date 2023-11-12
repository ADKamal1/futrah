import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:futrah/controller/resources/theme/colors_manager.dart';

void hintSnackBar({required String msg}) => toast(msg: msg, color: grey);

void loadingSnackBar({required String msg}) => toast(msg: msg, color: blue);

void successSnackBar({required String msg}) => toast(msg: msg, color: green);

void errorSnackBar({required String msg}) => toast(msg: msg, color: red);

void toast({required String msg, required Color color}) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.TOP,
    timeInSecForIosWeb: 1,
    backgroundColor: color,
    textColor: Colors.white,
    fontSize: 22,
  );
}

Color get red => AppColors.red;
Color get grey => Colors.grey;
Color get blue => AppColors.blue;
Color get green => AppColors.green;
