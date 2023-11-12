// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:futrah/controller/constants/logger.dart';
import 'package:futrah/controller/constants/strings.dart';
import 'package:futrah/controller/services/helpers/di.dart';
import 'package:futrah/controller/services/local/cache_helper.dart';
import 'package:futrah/controller/services/remote/dio_helper.dart';
import 'package:futrah/controller/services/remote/end_points.dart';
import 'package:futrah/view/screens/add_company/model/company_update_model.dart';
import 'package:futrah/view/screens/profile/cubit/profile_states.dart';
import 'package:futrah/view/screens/profile/model/about_us.dart';
import 'package:futrah/view/screens/profile/model/policy.dart';
import 'package:futrah/view/screens/profile/model/profile_model.dart';
import 'package:image_picker/image_picker.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit() : super(ProfileInitialState());

  static ProfileCubit get(context) => BlocProvider.of(context);
  final CacheHelper prefs = instance<CacheHelper>();
  var formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController taxNumberController = TextEditingController();
  TextEditingController taxRateController = TextEditingController();

  ProfileModel? userModel;
  Future<void> getProfileData() async {
    await DioHelper.getData(
      url: EndPoints.user,
    ).then((value) {
      emit(ProfileLoadingUserState());
      userModel = ProfileModel.fromJson(value.data);
      emit(ProfileSuccessUserState());
    }).catchError((error) {
      PrintLog.d(error.toString());
      emit(ProfileErrorUserState(error.toString()));
    });
  }

  /// =====================
  PolicyModel? policyModel;
  Future<void> getPolicy() async {
    await DioHelper.getData(
      url: EndPoints.policy,
    ).then((value) {
      emit(GetPolicyLoadingState());
      policyModel = PolicyModel.fromJson(value.data);
      emit(GetPolicySuccessState());
    }).catchError((error) {
      PrintLog.d(error.toString());
      emit(GetPolicyErrorState(error.toString()));
    });
  }

  /// =====================

  AboutUsModel? aboutUsModel;
  Future<void> getAboutUs() async {
    await DioHelper.getData(url: EndPoints.aboutUs).then((value) {
      emit(GetAboutUsLoadingState());
      aboutUsModel = AboutUsModel.fromJson(value.data);
      emit(GetAboutUsSuccessState());
    }).catchError((error) {
      PrintLog.d(error.toString());
      emit(GetAboutUsErrorState(error.toString()));
    });
  }

  /// ===================== logout ======================

  Future<void> logOut() async {
    emit(LogoutLoadingState());
    await DioHelper.postData(url: EndPoints.logout).then((value) {
      clearData();
      emit(LogoutSuccessState());
    }).catchError((error) {
      PrintLog.d(error.toString());
      emit(LogoutErrorState(error.toString()));
    });
  }

  /// ================== delete account ======================
  Future<void> deleteAccount() async {
    emit(DeleteAccountLoadingState());
    await DioHelper.deleteData(
      url: '${EndPoints.deleteAccount}/${AppStrings.userId}',
    ).then((value) {
      clearData();
      FirebaseAuth.instance.currentUser!.delete();
      emit(DeleteAccountSuccessState());
    }).catchError((error) {
      PrintLog.d(error.toString());
      emit(DeleteAccountErrorState(error.toString()));
    });
  }

  void clearData() {
    AppStrings.loginToken = '';
    AppStrings.userPhone = '';
    AppStrings.userUid = '';
    AppStrings.userId = 0;
    prefs.remove(key: 'token');
    prefs.remove(key: 'phone');
    prefs.remove(key: 'uid');
    prefs.remove(key: 'userId');
    // prefs.clear();
  }

  /// ===================== update profile img ======================

  CompanyUpdateModel? companyModel;
  Future<void> updateProfile() async {
    emit(EditProfileLoadingState());
    FormData formData = FormData.fromMap({
      'name': nameController.text,
      'address': addressController.text,
      'tax_number': taxNumberController.text,
      'tax_rate': int.parse(taxRateController.text),
    });
    formData.files
        .add(MapEntry('image', await MultipartFile.fromFile(image!.path)));
    await DioHelper.postData(
      url: '${EndPoints.companyUpdate}/${AppStrings.userId}',
      data: formData,
    ).then((value) {
      companyModel = CompanyUpdateModel.fromJson(value.data);
      emit(EditProfileSuccessState());
      _clear();
    }).catchError((error) {
      PrintLog.d(error.toString());
      emit(EditProfileErrorState(error.toString()));
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
      emit(SelectedImageState());
    }
  }
}
