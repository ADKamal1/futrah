import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:futrah/controller/constants/logger.dart';
import 'package:futrah/controller/constants/strings.dart';
import 'package:futrah/controller/services/remote/dio_helper.dart';
import 'package:futrah/controller/services/remote/end_points.dart';
import 'package:futrah/view/screens/add_category/cubit/category_state.dart';
import 'package:futrah/view/screens/add_category/model/add_category_model.dart';
import 'package:futrah/view/screens/home/model/categories_model.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitialState());

  static CategoryCubit get(context) => BlocProvider.of(context);
  TextEditingController categoryController = TextEditingController();

  AddCategoryModel? addCategoryModel;

  /// add new category
  Future<void> addNewCategory() async {
    emit(AddCategoryLoadingState());
    FormData formData = FormData.fromMap({
      'company_id': '${AppStrings.userId}',
      'title': categoryController.text,
    });
    await DioHelper.postData(
      url: EndPoints.addNewCategory,
      data: formData,
    ).then((value) {
      addCategoryModel = AddCategoryModel.fromJson(value.data);
      emit(AddCategorySuccessState(addCategoryModel!));
      categoryController.clear();
      getCategories();
    }).catchError((error) {
      PrintLog.d(error.toString());
      emit(AddCategoryErrorState(error.toString()));
    });
  }

  /// get all categories
  CategoriesModel? getCategoriesModel;
  Future<void> getCategories() async {
    emit(GetCategoryLoadingState());
    await DioHelper.getData(
      url: EndPoints.getAllCategory,
    ).then((value) {
      getCategoriesModel = CategoriesModel.fromJson(value.data);
      emit(GetCategorySuccessState(getCategoriesModel!));
    }).catchError((error) {
      PrintLog.d(error.toString());
      emit(GetCategoryErrorState(error.toString()));
    });
  }

  /// delete category
  Future<void> deleteCategory({required int id}) async {
    emit(DeleteCategoryLoadingState());
    await DioHelper.deleteData(
      url: '${EndPoints.deleteCategory}/$id',
    ).then((value) {
      emit(DeleteCategorySuccessState());
      getCategories();
    }).catchError((error) {
      PrintLog.d(error.toString());
      emit(DeleteCategoryErrorState(error.toString()));
    });
  }
}
