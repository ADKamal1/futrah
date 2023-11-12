import 'package:futrah/view/screens/add_product/model/add_product_model.dart';

abstract class ProductState {}

class ProductInitialState extends ProductState {}

class AddProductLoadingState extends ProductState {}

class AddProductSuccessState extends ProductState {
  final AddProductModel addProductModel;
  AddProductSuccessState(this.addProductModel);
}

class AddProductErrorState extends ProductState {
  final String error;
  AddProductErrorState(this.error);
}

class SelectedCategoryState extends ProductState {}

class ProductChangeIsTaxState extends ProductState {}
