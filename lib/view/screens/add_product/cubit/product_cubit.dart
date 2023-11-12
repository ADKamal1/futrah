// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:futrah/controller/constants/logger.dart';
import 'package:futrah/controller/constants/strings.dart';
import 'package:futrah/controller/services/remote/dio_helper.dart';
import 'package:futrah/controller/services/remote/end_points.dart';
import 'package:futrah/view/screens/add_product/cubit/product_state.dart';
import 'package:futrah/view/screens/add_product/model/add_product_model.dart';
import 'package:image_picker/image_picker.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitialState());

  static ProductCubit get(context) => BlocProvider.of(context);
  final formKey = GlobalKey<FormState>();
  TextEditingController productName = TextEditingController();
  TextEditingController productPrice = TextEditingController();
  TextEditingController productOptionalPrice = TextEditingController();
  String selectedCategory = '';
  bool withTax = true;
  bool withoutTax = false;

  File image = File('');

  AddProductModel? addProductModel;
  Future<void> addProduct() async {
    emit(AddProductLoadingState());

    FormData formData = FormData.fromMap({
      'category_id': selectedCategory,
      'title': productName.text,
      'price': productPrice.text,
      'optional_price':
          productOptionalPrice.text.isEmpty ? '0' : productOptionalPrice.text,
      'is_tax': withTax ? '1' : '0',
    });

    formData.files
        .add(MapEntry('image', await MultipartFile.fromFile(image.path)));

    await DioHelper.postData(
      url: EndPoints.addProductsStore,
      data: formData,
    ).then((value) {
      addProductModel = AddProductModel.fromJson(value.data);
      emit(AddProductSuccessState(addProductModel!));
      clearData();
    }).catchError((error) {
      PrintLog.d(error.toString());
      PrintLog.d(addProductModel?.errors?.error![0]);
      emit(AddProductErrorState(error.toString()));
    });
  }

  void clearData() {
    productName.clear();
    productPrice.clear();
    productOptionalPrice.clear();
    selectedCategory = '';
    image = File('');
  }

  /// ===================================================
  Future<void> getProduct() async {
    emit(AddProductLoadingState());
    await DioHelper.getData(
      url: '${EndPoints.getProductsStore}/${AppStrings.userId}',
    ).then((value) {
      addProductModel = AddProductModel.fromJson(value.data);

      emit(AddProductSuccessState(addProductModel!));
    }).catchError((error) {
      PrintLog.d(error.toString());
      emit(AddProductErrorState(error.toString()));
    });
  }

  /// ===================================================
  /*Future<void> deleteProduct({required String id}) async {
    emit(ProductLoadingState());
    await DioHelper.deleteData(
      url: '${EndPoints.deleteProductsStore}/$id',
    ).then((value) {
      addProductModel = AddProductModel.fromJson(value.data);
      emit(ProductSuccessState(addProductModel!));
    }).catchError((error) {
      appPrint(error.toString());
      appPrint(addProductModel!xx
      emit(ProductErrorState(error.toString()));
    });
  }*/

  /// ===================================================
  void chooseCategory(String v) {
    PrintLog.d(v);
    selectedCategory = v;
    emit(SelectedCategoryState());
  }

  /// ===================================================

  void chooseTax(bool value, int id) {
    if (id == 0) {
      withTax = true;
      withoutTax = false;
    } else {
      withTax = false;
      withoutTax = true;
    }

    emit(SelectedCategoryState());
  }

  void chooseImage() async {
    PickedFile? file =
        await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    if (file != null) {
      image = File(file.path);
      emit(SelectedCategoryState());
    }
  }
}
