import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:futrah/controller/constants/logger.dart';
import 'package:futrah/view/screens/home/cubit/home_cubit.dart';

import '../../../../controller/constants/components.dart';
import '../../../../controller/constants/strings.dart';
import '../../../../controller/resources/localizations/app_localizations.dart';
import '../../../../controller/services/remote/dio_helper.dart';
import '../../../../controller/services/remote/end_points.dart';
import '../../add_customers/model/get_customers_model.dart';
import '../model/make_bill_model.dart';
import 'pay_states.dart';

class PayCubit extends Cubit<PayStates> {
  PayCubit() : super(PayInitialState());

  static PayCubit get(context) => BlocProvider.of(context);
  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  bool printFatora = true;
  void changePrintFatora(bool val) {
    printFatora = val;
    PrintLog.d(val);
    emit(PayPrintFatoraState());
  }

  num getTotalPrice(context,
      {required List<int> productList, required Map idList}) {
    var cubit = HomeCubit.get(context);
    num totalPrice = 0;
    for (var i = 0; i < productList.length; i++) {
      var price = cubit.getAllProductModel!.data!
          .where(
            (element) => element.id == productList[i],
          )
          .toList()[0]
          .price;

      var quantity = idList.values.toList()[i];
      totalPrice += price! * quantity!;
    }
    return totalPrice;
  }

  /// ==================== Copy method ====================

  void copyMethod(context, text) {
    Clipboard.setData(ClipboardData(text: text)).then(
      (value) {
        successSnackBar(msg: 'copied_success'.tr(context));
        HapticFeedback.heavyImpact(); // for vibration
      },
    );
  }

  /// ================== Get Category for tapBar ======================

  int paymentMethod = 1;
  void changePaymentMethod({required int id}) {
    paymentMethod = id;
    // appPrint('paymentMethod=> $id');
    emit(PayPaymentMethodState());
  }

  /// =========================== create bill =================================
  MakeBillsModel? makeBillsModel;
  Future<void> makeBill({required Map idLists}) async {
    emit(MakeBillsLoadingState());

    List<Map> productsQuantity = [];
    idLists.forEach(
        (key, value) => productsQuantity.add({'id': key, 'quantity': value}));
    Map data = {
      'company_id': AppStrings.userId.toString(),
      'client_id': selectedCustomer == '' ? '1' : selectedCustomer,
      'payment_type': paymentMethod.toString(),
      'products': productsQuantity,
    };
    await DioHelper.postData(url: EndPoints.makeBill, data: data).then((value) {
      makeBillsModel = MakeBillsModel.fromJson(value.data);
      emit(MakeBillsSuccessState());
      paymentMethod = 0;
      selectedCustomer = '';
    }).catchError((error) {
      PrintLog.d(error.toString());
      emit(MakeBillsErrorState(error.toString()));
    });
  }

  /// ============================================================
  String selectedCustomer = '';
  void chooseCustomer(String v) {
    PrintLog.d(v);
    PrintLog.d(v.runtimeType);
    selectedCustomer = v;
    emit(SelectedCustomerState());
  }

  GetCustomersModel? getCustomersModel;
  Future<void> getCustomers() async {
    emit(GetCustomersLoadingState());
    await DioHelper.getData(
      url: EndPoints.getCustomers,
    ).then((value) {
      getCustomersModel = GetCustomersModel.fromJson(value.data);
      emit(GetCustomersSuccessState(getCustomersModel!));
    }).catchError((error) {
      PrintLog.d(error.toString());
      emit(GetCustomersErrorState(error.toString()));
    });
  }
}
