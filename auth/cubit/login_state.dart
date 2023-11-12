abstract class LoginState {}

class PhoneAuthInitial extends LoginState {}

class PhoneTermsCheckChanged extends LoginState {}

class ShopLoginIsPassword extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {}

class LoginErrorState extends LoginState {
  final String error;

  LoginErrorState(this.error);
}

class RegisterLoadingState extends LoginState {}

class RegisterSuccessState extends LoginState {}

class RegisterErrorState extends LoginState {
  final String error;

  RegisterErrorState(this.error);
}
