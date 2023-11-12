import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:futrah/controller/constants/logger.dart';
import 'package:futrah/controller/constants/strings.dart';
import 'package:futrah/controller/services/remote/dio_helper.dart';
import 'package:futrah/controller/services/remote/end_points.dart';
import 'package:futrah/view/screens/add_customers/cubit/customers_state.dart';
import 'package:futrah/view/screens/add_customers/model/add_customers_model.dart';
import 'package:futrah/view/screens/add_customers/model/get_customers_model.dart';

class CustomersCubit extends Cubit<CustomersState> {
  CustomersCubit() : super(CustomersInitialState());

  static CustomersCubit get(context) => BlocProvider.of(context);
  final formKey = GlobalKey<FormState>();
  TextEditingController customersName = TextEditingController();
  TextEditingController customersPhone = TextEditingController();
  TextEditingController taxNumber = TextEditingController();

  /// ======================= get clients ============================
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

  /// ======================= add clients ============================
  AddCustomersModel? addCustomersModel;
  Future<void> addCustomers() async {
    emit(AddCustomersLoadingState());

    FormData formData = FormData.fromMap({
      'company_id': AppStrings.userId,
      'name': customersName.text,
      'phone': customersPhone.text,
      'tax_number': taxNumber.text,
    });

    await DioHelper.postData(
      url: EndPoints.addCustomersStore,
      data: formData,
    ).then((value) {
      addCustomersModel = AddCustomersModel.fromJson(value.data);
      emit(AddCustomersSuccessState(addCustomersModel!));
      getCustomers();
      clearFields();
    }).catchError((error) {
      PrintLog.d(error.toString());
      emit(AddCustomersErrorState(error.toString()));
    });
  }

  void clearFields() {
    customersName.clear();
    customersPhone.clear();
    taxNumber.clear();
  }

  /// ======================= delete clients ============================
  Future<void> deleteCustomers({required int id}) async {
    emit(DeleteCustomersLoadingState());
    await DioHelper.deleteData(
      url: '${EndPoints.deleteCustomersStore}/$id',
    ).then((value) {
      addCustomersModel = AddCustomersModel.fromJson(value.data);
      emit(DeleteCustomersSuccessState());
      getCustomers();
    }).catchError((error) {
      PrintLog.d(error.toString());
      emit(DeleteCustomersErrorState(error.toString()));
    });
  }
}
