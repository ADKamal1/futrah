// import 'dart:async';
//
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:futrah/controller/constants/logger.dart';
// import 'package:futrah/controller/services/remote/dio_helper.dart';
// import 'package:futrah/controller/services/remote/end_points.dart';
// import 'package:futrah/view/screens/auth/cubit/login_state.dart';
//
// import '../model/login_model.dart';
// import '../model/registe_model.dart';
// import 'login_state.dart';
//
// class LoginCubit extends Cubit<LoginState> {
//   LoginCubit(super.initialState);
//
//   static LoginCubit get(context) => BlocProvider.of(context);
//
//   // late String verificationId;
//   // int? _resendToken;
//   // FirebaseAuth auth = FirebaseAuth.instance;
//   // final CacheHelper prefs = instance<CacheHelper>();
//   // TextEditingController otpController = TextEditingController();
//   //
//   // Future<void> submitPhoneNumber(String phoneNumber) async {
//   //   emit(PhoneAuthLoading());
//   //   await auth.verifyPhoneNumber(
//   //     phoneNumber: '${AppStrings.sudiaKey}$phoneNumber',
//   //     timeout: const Duration(seconds: 60),
//   //     verificationCompleted: (PhoneAuthCredential credential) async {
//   //       await auth.signInWithCredential(credential);
//   //     },
//   //     verificationFailed: (FirebaseAuthException error) {
//   //       emit(PhoneAuthError(errorMsg: error.toString()));
//   //     },
//   //     codeSent: (String verificationId, int? resendToken) {
//   //       this.verificationId = verificationId;
//   //       _resendToken = resendToken;
//   //       emit(PhoneNumberSubmited());
//   //     },
//   //     codeAutoRetrievalTimeout: (String verifyId) {},
//   //   );
//   // }
//   //
//   // Future<void> submitOTP(String otpCode) async {
//   //   emit(PhoneOTPLoading());
//   //   PhoneAuthCredential credential = PhoneAuthProvider.credential(
//   //       verificationId: verificationId, smsCode: otpCode);
//   //   await auth.signInWithCredential(credential);
//   //   emit(PhoneOTPVerified());
//   // }
//   //
//   // Future<bool> sendOTP(String phoneNumber) async {
//   //   await auth.verifyPhoneNumber(
//   //     phoneNumber: '${AppStrings.sudiaKey}$phoneNumber',
//   //     verificationCompleted: (PhoneAuthCredential credential) {},
//   //     verificationFailed: (FirebaseAuthException e) {},
//   //     codeSent: (String verificationId, int? resendToken) async {
//   //       verificationId = verificationId;
//   //       _resendToken = resendToken;
//   //     },
//   //     timeout: const Duration(seconds: 60),
//   //     forceResendingToken: _resendToken,
//   //     codeAutoRetrievalTimeout: (String verificationId) {
//   //       verificationId = verificationId;
//   //     },
//   //   );
//   //   debugPrint('verificationId: $verificationId');
//   //   return true;
//   // }
//   //
//   // int timerLeft = 60;
//   // bool isTimerFinished = false;
//   // Timer? timer;
//   //
//   // void startTimer() {
//   //   timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//   //     timerLeft > 0 ? timerLeft-- : timerLeft;
//   //     if (timerLeft == 0) {
//   //       timer.cancel();
//   //       isTimerFinished = true;
//   //     }
//   //     emit(PhoneAuthTimerChanged(timer: timerLeft));
//   //   });
//   // }
//   //
//   // void stopTimer() {
//   //   timer?.cancel();
//   //   timerLeft = 60;
//   //   isTimerFinished = false;
//   //   emit(PhoneAuthTimerChanged(timer: timerLeft));
//   // }
//   //
//   // /// ========================================= LOGIN FIREBASE Cubit =========================================
//   //
//   // SendLoginUid? uidModel;
//   // Future<void> sendLoginUid(
//   //     {required String phone, required String uid}) async {
//   //   emit(SendUidLoading());
//   //   FormData formData = FormData.fromMap({'firebase_id': uid, 'phone': phone});
//   //   await DioHelper.postData(url: EndPoints.sendUid, data: formData)
//   //       .then((value) {
//   //     uidModel = SendLoginUid.fromJson(value.data);
//   //     saveLocal();
//   //     emit(SendUidSuccess(uidModel!));
//   //   }).catchError((error) {
//   //     emit(SendUidError(error.toString()));
//   //   });
//   // }
//   //
//   // void saveLocal() {
//   //   prefs.save(key: 'token', value: uidModel!.data!.token);
//   //   prefs.save(key: 'uid', value: uidModel!.data!.fireBaseId);
//   //   prefs.save(key: 'userId', value: uidModel!.data!.id);
//   // }
//   //
//   // String countryCode = '+966';
//   // void changeCountryCode(String code) {
//   //   countryCode = code;
//   //   AppStrings.sudiaKey = code;
//   //   emit(PhoneCountryCodeChanged(code));
//   // }
//   /// ==================================================================================
//   bool isChecked = true;
//   // void changeCheck() {
//   //   isChecked = !isChecked;
//   //   emit(PhoneTermsCheckChanged());
//   // }
//
//   final GlobalKey<FormState> formKey = GlobalKey();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   TextEditingController rEmailController = TextEditingController();
//   TextEditingController rPasswordController = TextEditingController();
//   TextEditingController phoneController = TextEditingController();
//   TextEditingController nameController = TextEditingController();
//
//   IconData suffix = Icons.visibility_outlined;
//   bool isPassword = true;
//   void changeIcon() {
//     isPassword = !isPassword;
//     suffix =
//         isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
//     emit(ShopLoginIsPassword());
//   }
//
//   String? validateEmail(String value) {
//     if (value.isEmpty) {
//       return 'email_must_not_be_empty';
//     } else if (!value.contains('@')) {
//       return 'email_must_be_valid';
//     }
//     return null;
//   }
//
//   String? validatePassword(String value) {
//     if (value.isEmpty) {
//       return 'password_must_not_be_empty';
//     } else if (value.length < 8) {
//       return 'password_must_be_more_than_8_characters';
//     }
//     return null;
//   }
//
//   LoginModel? loginModel;
//   Future<void> login() async {
//     emit(LoginLoadingState());
//     FormData data = FormData.fromMap({
//       'email': emailController.text,
//       'password': passwordController.text,
//     });
//     await DioHelper.postData(url: EndPoints.login, data: data).then((value) {
//       loginModel = LoginModel.fromJson(value.data);
//       emit(LoginSuccessState());
//     }).catchError((error) {
//       PrintLog.e(error.toString());
//       emit(LoginErrorState(error));
//     });
//   }
//
//   RegisterModel? registerModel;
//   Future<void> register() async {
//     emit(RegisterLoadingState());
//     FormData data = FormData.fromMap({
//       'name': 'x', // nameController.text,
//       'email': '1ssz23@gmaifgdl.com', // rEmailController.text,
//       'phone': '1235495587463', // phoneController.text,
//       'password': '12345678', // rPasswordController.text,
//     });
//     await DioHelper.postData(url: EndPoints.register, data: data).then((value) {
//       PrintLog.i(value.data.toString());
//       registerModel = RegisterModel.fromJson(value.data);
//       emit(RegisterSuccessState());
//     }).catchError((error) {
//       PrintLog.e(error.toString());
//       emit(RegisterErrorState(error));
//     });
//   }
// }
