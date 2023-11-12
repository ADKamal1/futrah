abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

class GetCategoriesLoadingState extends HomeStates {}

class GetCategoriesSuccessState extends HomeStates {}

class GetCategoriesErrorState extends HomeStates {
  // final String error;
  //
  // GetCategoriesErrorState(this.error);
}

class GetProductLoadingState extends HomeStates {}

class GetProductSuccessState extends HomeStates {}

class GetProductErrorState extends HomeStates {
  final String error;

  GetProductErrorState(this.error);
}

class UpdateListHomeState extends HomeStates {}

class GetTotalPriceHomeState extends HomeStates {}

class ClearCartHomeState extends HomeStates {}

class IncrementQuantityState extends HomeStates {}

class DecreaseQuantityState extends HomeStates {}

class ChangeCartHomeState extends HomeStates {}

class GetAllProductLoadingState extends HomeStates {}

class GetAllProductSuccessState extends HomeStates {}

class GetAllProductErrorState extends HomeStates {
  final String error;

  GetAllProductErrorState(this.error);
}
