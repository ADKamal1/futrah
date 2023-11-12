import 'package:futrah/view/screens/auth/model/login_model.dart';

abstract class PhoneAuthState {}

class PhoneAuthInitial extends PhoneAuthState {}

class PhoneAuthLoading extends PhoneAuthState {}
class PhoneAuthSuccess extends PhoneAuthState {}
class PhoneAuthError extends PhoneAuthState {
  final String errorMsg;

  PhoneAuthError({required this.errorMsg});
}

class RegisterLoadingState extends PhoneAuthState{}



class RegisterSuccessState extends PhoneAuthState {}

class RegisterErrorState extends PhoneAuthState {
  final String error;

  RegisterErrorState(this.error);
}




class PhoneNumberSubmited extends PhoneAuthState {}

class PhoneOTPVerified extends PhoneAuthState {}

class PhoneOTPLoading extends PhoneAuthState {}
class PhoneOTPError extends PhoneAuthState {

  final String error;

  PhoneOTPError(this.error);
}

class PhoneAuthTimerChanged extends PhoneAuthState {
  final int timer;

  PhoneAuthTimerChanged({required this.timer});
}
//
// class SendUidSuccess extends PhoneAuthState {
//   final LoginModel uidMode;
//
//   SendUidSuccess(this.uidModel);
// }
//
// class SendUidLoading extends PhoneAuthState {}
//
// class SendUidError extends PhoneAuthState {
//   final String error;
//
//   SendUidError(this.error);
// }

class PhoneTermsCheckChanged extends PhoneAuthState {}

class PhoneCountryCodeChanged extends PhoneAuthState {
  final String countryCode;

  PhoneCountryCodeChanged(this.countryCode);
}






abstract class LoginState {}


class LoginInitial extends LoginState {}


class ShopLoginIsPassword extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {}

class LoginErrorState extends LoginState {
  final String error;

  LoginErrorState(this.error);
}




class PhoneNumberSubmitedr extends LoginState {}

class PhoneOTPVerifiedr extends LoginState {}

class PhoneOTPLoadingr extends LoginState {}

class PhoneAuthTimerChangedr extends LoginState {
  final int timer;

  PhoneAuthTimerChangedr({required this.timer});
}


// class SendUidSuccessr extends LoginState {
//   final SendLoginUid uidModel;
//
//   SendUidSuccessr(this.uidModel);
// }
//
// class SendUidLoadingr extends LoginState {}
//
// class SendUidErrorr extends LoginState {
//   final String error;
//
//   SendUidErrorr(this.error);
// }

class PhoneTermsCheckChangedr extends LoginState {}

class PhoneCountryCodeChangedr extends LoginState {
  final String countryCode;

  PhoneCountryCodeChangedr(this.countryCode);
}

class PhoneAuthLoadingr extends LoginState {}

class PhoneAuthErrorr extends LoginState {
  final String errorMsg;

  PhoneAuthErrorr({required this.errorMsg});
}