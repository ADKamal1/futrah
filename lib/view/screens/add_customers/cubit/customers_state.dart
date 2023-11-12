import 'package:futrah/view/screens/add_customers/model/add_customers_model.dart';
import 'package:futrah/view/screens/add_customers/model/get_customers_model.dart';

abstract class CustomersState {}

class CustomersInitialState extends CustomersState {}

/// add customers states
class AddCustomersLoadingState extends CustomersState {}

class AddCustomersSuccessState extends CustomersState {
  final AddCustomersModel addCustomersModel;
  AddCustomersSuccessState(this.addCustomersModel);
}

class AddCustomersErrorState extends CustomersState {
  final String error;
  AddCustomersErrorState(this.error);
}

/// get customers states
class GetCustomersLoadingState extends CustomersState {}

class GetCustomersSuccessState extends CustomersState {
  final GetCustomersModel getCustomersModel;
  GetCustomersSuccessState(this.getCustomersModel);
}

class GetCustomersErrorState extends CustomersState {
  final String error;
  GetCustomersErrorState(this.error);
}

/// delete customers states
/// get customers states
class DeleteCustomersLoadingState extends CustomersState {}

class DeleteCustomersSuccessState extends CustomersState {}

class DeleteCustomersErrorState extends CustomersState {
  final String error;
  DeleteCustomersErrorState(this.error);
}
