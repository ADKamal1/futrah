import 'package:futrah/view/screens/add_customers/model/add_customers_model.dart';
import 'package:futrah/view/screens/add_customers/model/get_customers_model.dart';

abstract class PayStates {}

class PayInitialState extends PayStates {}

class PayPrintFatoraState extends PayStates {}

class PayPaymentMethodState extends PayStates {}

/// make bill state
class MakeBillsLoadingState extends PayStates {}

class MakeBillsSuccessState extends PayStates {}

class MakeBillsErrorState extends PayStates {
  final String error;
  MakeBillsErrorState(this.error);
}

/// add customer state

class AddCustomersLoadingState extends PayStates {}

class AddCustomersSuccessState extends PayStates {
  final AddCustomersModel addCustomersModel;
  AddCustomersSuccessState(this.addCustomersModel);
}

class AddCustomersErrorState extends PayStates {
  final String error;
  AddCustomersErrorState(this.error);
}

/// get customer state

class GetCustomersLoadingState extends PayStates {}

class GetCustomersSuccessState extends PayStates {
  final GetCustomersModel getCustomersModel;
  GetCustomersSuccessState(this.getCustomersModel);
}

class GetCustomersErrorState extends PayStates {
  final String error;
  GetCustomersErrorState(this.error);
}

class SelectedCustomerState extends PayStates {}
