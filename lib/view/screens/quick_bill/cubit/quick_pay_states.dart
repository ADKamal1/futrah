abstract class QuickBillStates {}

class QuickPayInitialState extends QuickBillStates {}

class MakeQuickBillLoadingState extends QuickBillStates {}

class MakeQuickBillSuccessState extends QuickBillStates {}

class MakeQuickBillErrorState extends QuickBillStates {
  final String error;

  MakeQuickBillErrorState(this.error);
}

class GetQuickSingleBillLoadingState extends QuickBillStates {}

class GetQuickSingleBillSuccessState extends QuickBillStates {}

class GetQuickSingleBillErrorState extends QuickBillStates {
  final String error;
  GetQuickSingleBillErrorState(this.error);
}
