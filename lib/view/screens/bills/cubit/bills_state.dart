abstract class BillsState {}

class BillsInitialState extends BillsState {}

/// get single bill state
class GetSingleBillLoadingState extends BillsState {}

class GetSingleBillSuccessState extends BillsState {}

class GetSingleBillErrorState extends BillsState {
  final String error;
  GetSingleBillErrorState(this.error);
}

/// get all bills state

class GetAllBillsLoadingState extends BillsState {}

class GetAllBillsSuccessState extends BillsState {}

class GetAllBillsErrorState extends BillsState {
  final String error;
  GetAllBillsErrorState(this.error);
}

/// delete bill state

class DeleteBillLoadingState extends BillsState {}

class DeleteBillSuccessState extends BillsState {}

class DeleteBillErrorState extends BillsState {
  final String error;
  DeleteBillErrorState(this.error);
}
