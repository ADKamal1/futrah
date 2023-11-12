import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:futrah/controller/constants/logger.dart';
import 'package:futrah/controller/constants/strings.dart';
import 'package:futrah/controller/services/remote/dio_helper.dart';
import 'package:futrah/controller/services/remote/end_points.dart';
import 'package:futrah/view/screens/quick_bill/cubit/quick_pay_states.dart';
import 'package:futrah/view/screens/quick_bill/model/get_quick_bill_model.dart';
import 'package:futrah/view/screens/quick_bill/model/make_quick_bill_model.dart';

class QuickPayCubit extends Cubit<QuickBillStates> {
  QuickPayCubit() : super(QuickPayInitialState());

  static QuickPayCubit get(context) => BlocProvider.of(context);
  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  /// ================== Get Category for tapBar ======================
  MakeQuickBillModel? quickBillsModel;
  Future<void> makeQuickBills() async {
    emit(MakeQuickBillLoadingState());
    FormData formData = FormData.fromMap({
      'company_id': AppStrings.userId,
      'name': nameController.text,
      'price': priceController.text,
    });
    await DioHelper.postData(url: EndPoints.makeQuickBill, data: formData)
        .then((value) {
      quickBillsModel = MakeQuickBillModel.fromJson(value.data);
      emit(MakeQuickBillSuccessState());
      clearData();
    }).catchError((error) {
      PrintLog.d(error.toString());
      emit(MakeQuickBillErrorState(error.toString()));
    });
  }

  void clearData() {
    nameController.clear();
    priceController.clear();
  }

  /// =========================== get single bill =================================
  GetQuickBillModel? getQBillModel;
  Future<void> getQuickBill({required int id}) async {
    emit(GetQuickSingleBillLoadingState());
    await DioHelper.getData(
      url: '${EndPoints.getSingleBill}/$id?quick=1',
    ).then((value) {
      getQBillModel = GetQuickBillModel.fromJson(value.data);
      PrintLog.d(value.data.toString());
      emit(GetQuickSingleBillSuccessState());
    }).catchError((error) {
      PrintLog.d(error.toString());
      emit(GetQuickSingleBillErrorState(error.toString()));
    });
  }
}
