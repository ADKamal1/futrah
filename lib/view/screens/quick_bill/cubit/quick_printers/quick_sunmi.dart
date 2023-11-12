import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:futrah/controller/integration/bluetooth/print_page.dart';
import 'package:futrah/controller/routes/app_router_imports.dart';
import 'package:futrah/view/screens/quick_bill/cubit/quick_pay_cubit.dart';
import 'package:intl/intl.dart' as intl;
import 'package:sunmi_printer_plus/enums.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';

class QuickSunmi {
  Future<void> initialize() async {
    await SunmiPrinter.bindingPrinter();
    await SunmiPrinter.startTransactionPrint(true);
    await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
  }

  Future<void> printReceipt(context) async {
    var model = QuickPayCubit.get(context).getQBillModel;
    await initialize();
    await printImage('${model!.companyLogo}');
    await _generateMixedLine(body: model.data![0].company!.name!);
    await printInvoice(context);
    await printImage('${model.qrView}');
    await _closePrinter().then((value) {
      return pushNamed(context, route: Routes.home);
    });
  }

  Future<void> printImage(String img) async {
    Uint8List fileData = await _getLogoImageFileFromUrl(img);
    await SunmiPrinter.printImage(fileData);
  }

  Future<void> printQr(String qr) async => await SunmiPrinter.printQRCode(qr);

  Future<void> printInvoice(context) async {
    var qModel = QuickPayCubit.get(context).getQBillModel;
    var model = qModel!.data![0];
    var company = qModel.data![0].company!;
    await _generateMixedLine(body: simpleTaxAr);
    await _generateMixedLine(body: simpleTaxEn);
    await _generateMixedLine(
      titleEnStart: 'الكاشير',
      body: 'الوقت',
      titleArEnd: 'التاريخ',
    );
    await _generateMixedLine(
      titleEnStart: anon,
      body: _time,
      titleArEnd: _date,
    );
    await _generateMixedLine(
      titleArEnd: 'الرقم المرجعي',
      titleEnStart: company.taxNumber.toString(),
    );
    await _generateMixedLine(
      titleArEnd: 'رقم الجهاز',
      titleEnStart: await SunmiPrinter.serialNumber(),
    );
    await _generateMixedLine(
      titleArEnd: 'رقم الفاتورة',
      titleEnStart: model.id.toString(),
    );
    await _generateMixedLine(
      titleEnStart: 'اسم الصنف',
      titleArEnd: 'السعر',
    );
    await _generateMixedLine(
      titleEnStart: '${model.name}',
      titleArEnd: '${model.price} SAR',
    );
    await _generateMixedLine(
      titleEnStart: 'مبلغ الفاتوره الاجمالي',
      titleArEnd: '${model.finalPrice} SAR',
    );
    await _generateMixedLine(
      titleEnStart: 'المبلغ غير شامل الضريبه',
      titleArEnd: '${model.price} SAR',
    );
    await _generateMixedLine(
      titleEnStart: 'مجموع الضريبه المضافه',
      titleArEnd: '${model.tax} SAR',
    );
    await _generateMixedLine(
      titleEnStart: 'المبلغ الاجمالي',
      titleArEnd: '${model.finalPrice} SAR',
    );
    await printQr('${qModel.qrBase64}');
  }
}

Future<void> _closePrinter() async {
  await SunmiPrinter.lineWrap(2);
  await SunmiPrinter.cut();
  Future.delayed(const Duration(seconds: 1))
      .then((value) async => await SunmiPrinter.exitTransactionPrint(true));
}

Future<void> _generateMixedLine({
  String titleEnStart = '',
  String body = '',
  String titleArEnd = '',
}) async {
  if (body.length > 22 && titleEnStart.isNotEmpty) {
    int index = -1;
    for (int i = 22; i >= 0; i--) {
      if (body[i] == ' ') {
        index = i;
        break;
      }
    }
    body = '${body.substring(0, index)}\n${body.substring(index, body.length)}';
  }
  Uint8List imageBytes = await _generateImageFromListString(
    [titleEnStart, body, titleArEnd],
  );
  await SunmiPrinter.printImage(imageBytes);
}

Future<Uint8List> _generateImageFromListString(List<String> text,
    {double enTxtSize = 23.0}) async {
  TextSpan spanEn = TextSpan(
      style: TextStyle(
        color: Colors.black,
        fontSize: enTxtSize,
        fontWeight: FontWeight.bold,
      ),
      text: text.first);
  TextSpan spanAr = TextSpan(
      style: TextStyle(
          color: Colors.black,
          fontSize:
              (text.last.contains('Canc') || text.last.contains('Additional'))
                  ? 30
                  : 23,
          fontWeight: FontWeight.bold),
      text: text.last);
  TextSpan spanValue = TextSpan(
      style: const TextStyle(
          color: Colors.black, fontSize: 27, fontWeight: FontWeight.bold),
      text: text[1]);

  TextPainter tpEn = TextPainter(
      text: spanEn,
      maxLines: 3,
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr);
  TextPainter tpAr = TextPainter(
      text: spanAr,
      maxLines: 3,
      textAlign: TextAlign.right,
      textDirection: TextDirection.rtl);
  TextPainter tpValue = TextPainter(
      text: spanValue,
      maxLines: 3,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr);

  ui.PictureRecorder recorder = ui.PictureRecorder();
  Canvas canvas = Canvas(recorder,
      Rect.fromCenter(center: const Offset(0, 0), width: 580, height: 400));
  canvas.drawColor(Colors.white, BlendMode.color);

  tpEn.layout(minWidth: 550, maxWidth: 550);
  tpAr.layout(minWidth: 550, maxWidth: 550);
  tpValue.layout(minWidth: 550, maxWidth: 550);

  tpEn.paint(canvas, const Offset(0.0, 0.0));
  tpAr.paint(canvas, const Offset(0.0, 0.0));
  tpValue.paint(canvas, const Offset(0.0, 0.0));

  var picture = recorder.endRecording();
  final pngBytes = await picture.toImage(
      (tpEn.size.width * (5 / 8)).toInt(),
      text[1].length > 25
          ? tpEn.size.height.toInt() * 3
          : (text.last.contains('Canc') || text.last.contains('Additional'))
              ? tpEn.size.height.toInt() * 3
              : tpEn.size.height.toInt() + 9);
  final byteData = await pngBytes.toByteData(format: ui.ImageByteFormat.png);
  return byteData!.buffer.asUint8List();
}

String get _date => intl.DateFormat('yyyy-MM-dd').format(DateTime.now());
String get _time => intl.DateFormat('kk:mm:ss').format(DateTime.now());

Future<Uint8List> _getLogoImageFileFromUrl(String url) async {
  final ByteData imageData = await NetworkAssetBundle(
    Uri.parse(url),
  ).load('');
  return imageData.buffer.asUint8List();
}
