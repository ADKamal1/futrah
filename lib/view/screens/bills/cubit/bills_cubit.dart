import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:futrah/controller/constants/logger.dart';
import 'package:futrah/controller/services/remote/dio_helper.dart';
import 'package:futrah/controller/services/remote/end_points.dart';
import 'package:futrah/view/screens/bills/cubit/bills_state.dart';
import 'package:futrah/view/screens/bills/model/all_bills_model/all_bills.dart';
import 'package:futrah/view/screens/bills/model/single_bill_model/single_bill_model.dart';
import 'package:futrah/view/screens/pay/model/make_bill_model.dart';

class BillsCubit extends Cubit<BillsState> {
  BillsCubit() : super(BillsInitialState());

  static BillsCubit get(context) => BlocProvider.of(context);
  TextEditingController cardController = TextEditingController();

  /// =========================== get single bill =================================
  SingleBillModel? singleBillModel;
  Future<void> getSingleBill({required int id}) async {
    emit(GetSingleBillLoadingState());
    await DioHelper.getData(
      url: '${EndPoints.getSingleBill}/$id',
    ).then((value) {
      singleBillModel = SingleBillModel.fromJson(value.data);
      emit(GetSingleBillSuccessState());
    }).catchError((error) {
      PrintLog.d(error.toString());
      emit(GetSingleBillErrorState(error.toString()));
    });
  }

  /// =========================== get all bills =================================
  GetAllBills? getAllBillsModel;
  Future<void> getAllBills() async {
    emit(GetAllBillsLoadingState());
    await DioHelper.getData(
      url: EndPoints.getAllBills,
    ).then((value) {
      getAllBillsModel = GetAllBills.fromJson(value.data);
      emit(GetAllBillsSuccessState());
    }).catchError((error) {
      PrintLog.d(error.toString());
      emit(GetAllBillsErrorState(error.toString()));
    });
  }

  /// =========================== delete bill=================================

  MakeBillsModel? makeBillsModel;
  Future<void> deleteBill({required int id}) async {
    emit(DeleteBillLoadingState());
    await DioHelper.deleteData(
      url: '${EndPoints.deleteBill}/$id',
    ).then((value) {
      makeBillsModel = MakeBillsModel.fromJson(value.data);
      emit(DeleteBillSuccessState());
      getAllBills();
    }).catchError((error) {
      PrintLog.d(error.toString());
      emit(DeleteBillErrorState(error.toString()));
    });
  }
}
