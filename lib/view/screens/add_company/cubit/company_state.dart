abstract class CompanyState {}

class CompanyInitialState extends CompanyState {}

class CompanyLoadingState extends CompanyState {}

class CompanySuccessState extends CompanyState {}

class CompanyErrorState extends CompanyState {
  final String error;

  CompanyErrorState(this.error);
}

class SelectedImgState extends CompanyState {}
