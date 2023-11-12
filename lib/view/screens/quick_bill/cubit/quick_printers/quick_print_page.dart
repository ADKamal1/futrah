import 'package:blue_print_pos/blue_print_pos.dart';
import 'package:blue_print_pos/models/models.dart';
import 'package:blue_print_pos/receipt/receipt.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:futrah/controller/constants/logger.dart';
import 'package:futrah/controller/integration/bluetooth/print_page.dart';
import 'package:futrah/controller/resources/localizations/app_localizations.dart';
import 'package:futrah/controller/resources/theme/colors_manager.dart';
import 'package:futrah/controller/routes/app_router_imports.dart';
import 'package:futrah/view/screens/quick_bill/cubit/quick_pay_cubit.dart';
import 'package:futrah/view/widgets/custom_app_bar.dart';
import 'package:futrah/view/widgets/custom_loading.dart';
import 'package:futrah/view/widgets/my_text.dart';
import 'package:http/http.dart' as http;

class QuickPrintPage extends StatefulWidget {
  final int id;
  const QuickPrintPage({super.key, required this.id});

  @override
  State<QuickPrintPage> createState() => _QuickPrintPageState();
}

class _QuickPrintPageState extends State<QuickPrintPage> {
  final BluePrintPos _bluePrintPos = BluePrintPos.instance;
  List<BlueDevice> _blueDevices = <BlueDevice>[];
  BlueDevice? _selectedDevice;
  bool _isLoading = false;
  int _loadingAtIndex = -1;

  @override
  void initState() {
    super.initState();
    QuickPayCubit.get(context).getQuickBill(id: widget.id);
    setState(() => _isLoading = true);
    _bluePrintPos.scan().then((List<BlueDevice> devices) {
      if (devices.isNotEmpty) {
        setState(() {
          _blueDevices = devices;
          _isLoading = false;
        });
      } else {
        setState(() => _isLoading = false);
      }
    });
    // if device is connected , print receipt
    _bluePrintPos.isConnected ? _onPrintReceipt() : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leading: IconButton(
          onPressed: () => pushReplacementNamed(context, Routes.home),
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
            onPressed: _isLoading ? null : onScanPressed,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: _isLoading && _blueDevices.isEmpty
          ? const AppLoading()
          : _blueDevices.isNotEmpty
              ? Directionality(
                  textDirection: TextDirection.ltr,
                  child: ListView(
                    children: List.generate(_blueDevices.length, (int index) {
                      return GestureDetector(
                        onTap: _blueDevices[index].address ==
                                (_selectedDevice?.address ?? '')
                            ? _onDisconnectDevice
                            : () => _onSelectDevice(index),
                        child: Container(
                          color: _selectedDevice?.address ==
                                  _blueDevices[index].address
                              ? Colors.grey[200]
                              : Colors.white,
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        _blueDevices[index].name,
                                        style: TextStyle(
                                          color: _selectedDevice?.address ==
                                                  _blueDevices[index].address
                                              ? Colors.blue
                                              : Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        _blueDevices[index].address,
                                        style: TextStyle(
                                          color: _selectedDevice?.address ==
                                                  _blueDevices[index].address
                                              ? Colors.blueGrey
                                              : Colors.grey,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              if (_loadingAtIndex == index && _isLoading)
                                const AppLoading(size: 24),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyText(
                        title: 'no_devices'.tr(context),
                        size: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                      ElevatedButton(
                        onPressed: _isLoading ? null : onScanPressed,
                        child: MyText(
                          title: 'refresh'.tr(context),
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
    );
  }

  Future<void> onScanPressed() async {
    setState(() => _isLoading = true);
    _bluePrintPos.scan().then((List<BlueDevice> devices) {
      if (devices.isNotEmpty) {
        setState(() {
          _blueDevices = devices;
          _isLoading = false;
        });
      } else {
        setState(() => _isLoading = false);
      }
    });
  }

  void _onDisconnectDevice() {
    _bluePrintPos.disconnect().then((ConnectionStatus status) {
      if (status == ConnectionStatus.disconnect) {
        setState(() {
          _selectedDevice = null;
        });
      }
    });
  }

  void _onSelectDevice(int index) {
    setState(() {
      _isLoading = true;
      _loadingAtIndex = index;
    });
    final BlueDevice blueDevice = _blueDevices[index];
    _bluePrintPos.connect(blueDevice).then((ConnectionStatus status) {
      if (status == ConnectionStatus.connected) {
        setState(() => _selectedDevice = blueDevice);
        Future.delayed(const Duration(seconds: 2), () {
          _onPrintReceipt();
        });
      } else if (status == ConnectionStatus.timeout) {
        _onDisconnectDevice();
      } else {
        PrintLog.d('$runtimeType - something wrong');
      }
      setState(() => _isLoading = false);
    });
  }

  Future<void> _onPrintReceipt() async {
    final allM = QuickPayCubit.get(context).getQBillModel!;
    final model = QuickPayCubit.get(context)
        .getQBillModel!
        .data!
        .where((element) => element.id == widget.id)
        .first;
    final finalPrice = model.finalPrice!;
    final price = model.price;
    final tax = model.tax;

    /// ================== Receipt Text ==================
    final ReceiptSectionText r = ReceiptSectionText();
    var response = await http.get(Uri.parse(allM.companyLogo.toString()));
    var imageData = response.bodyBytes;
    var imageBytes = Uint8List.fromList(imageData);
    await _bluePrintPos.printReceiptImage(imageBytes, width: 40 * 8);
    r.addText('${model.company!.name}',
        size: ReceiptTextSizeType.large, style: ReceiptTextStyleType.bold);
    r.addText(simpleTaxEn,
        alignment: ReceiptAlignment.center, style: ReceiptTextStyleType.bold);
    r.addText(simpleTaxAr,
        alignment: ReceiptAlignment.center, style: ReceiptTextStyleType.bold);
    r.addSpacer(useDashed: true);
    r.addLeftRightText(anon, 'الكاشير');
    r.addLeftRightText(timeText, 'الوقت');
    r.addLeftRightText(dateText, 'التاريخ');
    r.addSpacer(useDashed: true);
    r.addLeftRightText('${model.id}', 'الرقم المرجعي');
    r.addLeftRightText(getDeviceAddress, 'رقم الجهاز');
    r.addLeftRightText('${model.id}', 'رقم الفاتوره');
    r.addLeftRightText('${allM.taxNumber}', 'الرقم الضريبي للمنشئه');
    r.addLeftRightText('Main Branch', 'الفرع');
    r.addLeftRightText('$finalPrice SAR', 'نقدا');
    r.addSpacer(useDashed: true);
    r.addLeftRightText('${model.name}', 'اسم المنتج');
    r.addLeftRightText('$price', 'السعر');
    r.addSpacer(useDashed: true);
    r.addText('${'$finalPrice SAR'}مبلغ الفاتوره الاجمالي ',
        alignment: ReceiptAlignment.left);
    r.addSpacer(useDashed: true);
    r.addLeftRightText('$price$sarAr', tpOutTaxAr);
    r.addLeftRightText('$price SAR', tpOutTaxEn);
    r.addLeftRightText('$price$sarAr', totalVATAr);
    r.addLeftRightText('$price SAR', totalVATEn);
    r.addLeftRightText('$tax$sarAr', totalVATP);
    r.addLeftRightText('$tax SAR', 'Total VAT (15%)');
    r.addSpacer(useDashed: true);
    r.addLeftRightText('$finalPrice$sarAr', 'اجمالي المبلغ');
    r.addLeftRightText('$finalPrice SAR', 'Total Amount');
    await _bluePrintPos.printReceiptText(r);
    await _bluePrintPos.printQR(allM.qrBase64!, size: 200).then((value) {
      return pushNamed(context, route: Routes.home);
    });
    r.addSpacer(useDashed: true);
  }

  String get getDeviceAddress => _bluePrintPos.selectedDevice!.address;
}
