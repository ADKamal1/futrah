// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:ffi';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:futrah/controller/constants/logger.dart';
import 'package:futrah/controller/constants/strings.dart';
import 'package:futrah/controller/services/helpers/di.dart';
import 'package:futrah/controller/services/local/cache_helper.dart';
import 'package:futrah/controller/services/remote/dio_helper.dart';
import 'package:futrah/controller/services/remote/end_points.dart';
import 'package:futrah/view/screens/add_company/cubit/company_state.dart';
import 'package:futrah/view/screens/add_company/model/company_update_model.dart';
import 'package:image_picker/image_picker.dart';

class CompanyCubit extends Cubit<CompanyState> {
  CompanyCubit() : super(CompanyInitialState());

  static CompanyCubit get(context) => BlocProvider.of(context);
  FirebaseAuth auth = FirebaseAuth.instance;
  final CacheHelper prefs = instance<CacheHelper>();
  // void getLocal() {
  //   AppStrings.loginToken = prefs.get(key: 'token') ?? '';
  //   AppStrings.userPhone = prefs.get(key: 'phone') ?? '';
  //   AppStrings.userUid = prefs.get(key: 'uid') ?? '';
  //   AppStrings.userId = prefs.get(key: 'userId') ?? 0;
  // }

  var formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController taxNumberController = TextEditingController();
  TextEditingController taxRateController = TextEditingController();

  ///===============================================
  CompanyUpdateModel? companyModel;
  Future<void> updateCompanyData() async {
    emit(CompanyLoadingState());
    FormData formData = FormData.fromMap({
      'name': nameController.text,
      'address': addressController.text,
      'tax_number': taxNumberController.text,
      'tax_rate': double.parse(taxRateController.text),
    });
    formData.files
        .add(MapEntry('image', await MultipartFile.fromFile(image!.path)));
    await DioHelper.postData(
      url: '${EndPoints.companyUpdate}/${AppStrings.userId}',
      data: formData,
    ).then((value) {
      companyModel = CompanyUpdateModel.fromJson(value.data);
      emit(CompanySuccessState());
      _clear();
    }).catchError((error) {
      PrintLog.d(error.toString());
      emit(CompanyErrorState(error.toString()));
    });
  }

  void _clear() {
    nameController.clear();
    addressController.clear();
    taxNumberController.clear();
    taxRateController.clear();
    image = null;
  }

  /// ===============================================
  File? image;
  void chooseImage() async {
    PickedFile? file =
        await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    if (file != null) {
      image = File(file.path);
      emit(SelectedImgState());
    }
  }
}
