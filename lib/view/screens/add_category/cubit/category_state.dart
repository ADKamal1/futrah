import 'package:futrah/view/screens/add_category/model/add_category_model.dart';
import 'package:futrah/view/screens/home/model/categories_model.dart';

abstract class CategoryState {}

class CategoryInitialState extends CategoryState {}

/// add category
class AddCategoryLoadingState extends CategoryState {}

class AddCategorySuccessState extends CategoryState {
  final AddCategoryModel addCategoryModel;
  AddCategorySuccessState(this.addCategoryModel);
}

class AddCategoryErrorState extends CategoryState {
  final String error;
  AddCategoryErrorState(this.error);
}

/// get categories

class GetCategoryLoadingState extends CategoryState {}

class GetCategorySuccessState extends CategoryState {
  final CategoriesModel getCategoryModel;
  GetCategorySuccessState(this.getCategoryModel);
}

class GetCategoryErrorState extends CategoryState {
  final String error;
  GetCategoryErrorState(this.error);
}

/// delete category

class DeleteCategoryLoadingState extends CategoryState {}

class DeleteCategorySuccessState extends CategoryState {}

class DeleteCategoryErrorState extends CategoryState {
  final String error;
  DeleteCategoryErrorState(this.error);
}
