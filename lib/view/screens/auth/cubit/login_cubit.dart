import 'dart:async';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:futrah/controller/constants/strings.dart';
import 'package:futrah/controller/services/helpers/di.dart';
import 'package:futrah/controller/services/local/cache_helper.dart';
import 'package:futrah/controller/services/remote/dio_helper.dart';
import 'package:futrah/controller/services/remote/end_points.dart';
import 'package:futrah/view/screens/auth/cubit/login_state.dart';
import 'package:futrah/view/screens/auth/model/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../controller/constants/components.dart';
import '../../../../controller/constants/logger.dart';

class PhoneAuthCubit extends Cubit<PhoneAuthState> {
  static PhoneAuthCubit get(context) => BlocProvider.of(context);

  PhoneAuthCubit() : super(PhoneAuthInitial());
  late String verificationId;
  String? _resendToken;
  FirebaseAuth auth = FirebaseAuth.instance;
  final CacheHelper prefs = instance<CacheHelper>();
  TextEditingController otpController = TextEditingController();
  LoginCubit cubit=LoginCubit();
  final GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rEmailController = TextEditingController();
  TextEditingController rPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
RegisterModel? registerModel;
  Future<void> activeAccountWithOTP(String phone,String OTPCode) async {
    emit(PhoneOTPLoading());
    FormData data = FormData.fromMap({
      'phone':"${phone}",
      'code':  OTPCode,
    });

    await DioHelper.postData(url: EndPoints.activateAccount, data: data).then((value) {
      PrintLog.i(value.data.toString());
        registerModel = RegisterModel.fromJson(value.data);

if(registerModel!.code ==200) {
          emit(PhoneOTPVerified());

      }
    }).catchError((error) {
      PrintLog.e(error.toString());
      emit(PhoneOTPError(error));
    });
  }

  //

  LoginModel? loginModel0;
  Future<void> submitPhoneNumber(String phoneNumber, String password ) async {
    emit(PhoneAuthLoading());

    FormData data = FormData.fromMap({
      'phone':phoneNumber,
      ' password':password ,
    });

    await DioHelper.postData(url: EndPoints.login, data: data).then((value) {

      loginModel0 = LoginModel.fromJson(value.data);

      if(loginModel0!.code == 200) {

        saveLocal();

       save();
        PrintLog.i(prefs.get(key: 'token'));
        emit(PhoneAuthSuccess());

      }
      else{
        if(loginModel0!.errors !=null) {
          PrintLog.e(loginModel0!.errors.toString());
          emit(PhoneAuthError(errorMsg: loginModel0!.errors.toString()));
        }
      }
    });

    // await auth.verifyPhoneNumber(
    //   phoneNumber: 'phoneNumber',
    //   timeout: const Duration(seconds: 60),
    //   verificationCompleted: (PhoneAuthCredential credential) async {
    //     await auth.signInWithCredential(credential);
    //   },
    //   verificationFailed: (FirebaseAuthException error) {
    //     emit(PhoneAuthError(errorMsg: error.toString()));
    //   },
    //   codeSent: (String verificationId, int? resendToken) {
    //     this.verificationId = verificationId;
    //     _resendToken = resendToken;
    //     emit(PhoneNumberSubmited());
    //   },
    //   codeAutoRetrievalTimeout: (String verifyId) {},
    // );
  }

  void saveLocal() {
    prefs.save(key: 'token', value: loginModel0!.data!.token);
    prefs.save(key: 'uid', value: loginModel0!.data!.fireBaseId);
    prefs.save(key: 'userId', value: loginModel0!.data!.id);
  }

  void save() {
    final CacheHelper prefs = instance<CacheHelper>();
    AppStrings.loginToken = prefs.get(key: 'token') ?? '';
    AppStrings.userPhone = prefs.get(key: 'phone') ?? '';
    AppStrings.userUid = prefs.get(key: 'uid') ?? '';
    AppStrings.userId = prefs.get(key: 'userId') ?? 0;
  }
  //
  // Future<bool> sendOTP(String phoneNumber) async {
  //   await auth.verifyPhoneNumber(
  //     phoneNumber: '${AppStrings.sudiaKey}$phoneNumber',
  //     verificationCompleted: (PhoneAuthCredential credential) {},
  //     verificationFailed: (FirebaseAuthException e) {},
  //     codeSent: (String verificationId, int? resendToken) async {
  //       verificationId = verificationId;
  //       _resendToken = resendToken;
  //     },
  //     timeout: const Duration(seconds: 60),
  //     forceResendingToken: _resendToken,
  //     codeAutoRetrievalTimeout: (String verificationId) {
  //       verificationId = verificationId;
  //     },
  //   );
  //   debugPrint('verificationId: $verificationId');
  //   return true;
  // }

  int timerLeft = 60;
  bool isTimerFinished = false;
  Timer? timer;

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      timerLeft > 0 ? timerLeft-- : timerLeft;
      if (timerLeft == 0) {
        timer.cancel();
        isTimerFinished = true;
      }
      emit(PhoneAuthTimerChanged(timer: timerLeft));
    });
  }

  void stopTimer() {
    timer?.cancel();
    timerLeft = 60;
    isTimerFinished = false;
    emit(PhoneAuthTimerChanged(timer: timerLeft));
  }
  //
  // void saveLocal() {
  //   prefs.save(key: 'token', value: uidModel!.data!.token);
  //   prefs.save(key: 'uid', value: uidModel!.data!.fireBaseId);
  //   prefs.save(key: 'userId', value: uidModel!.data!.id);
  // }

  /// ========================================= LOGIN FIREBASE Cubit =========================================

  // SendLoginUid? uidModel;
  // Future<void> sendLoginUid(
  //     {required String phone, required String uid}) async {
  //   emit(SendUidLoading());
  //   FormData formData = FormData.fromMap({'firebase_id': uid, 'phone': phone});
  //   await DioHelper.postData(url: EndPoints.sendUid, data: formData)
  //       .then((value) {
  //     uidModel = SendLoginUid.fromJson(value.data);
  //     saveLocal();
  //     emit(SendUidSuccess(uidModel!));
  //   }).catchError((error) {
  //     emit(SendUidError(error.toString()));
  //   });
  // }

  /// ==================================================================================
  bool isChecked = true;
  void changeCheck() {
    isChecked = !isChecked;
    emit(PhoneTermsCheckChanged());
  }

  String countryCode = '+966';
  void changeCountryCode(String code) {
    countryCode = code;
    AppStrings.sudiaKey = code;
    emit(PhoneCountryCodeChanged(code));
  }
}





class LoginCubit extends Cubit<LoginState> {
  static LoginCubit get(context) => BlocProvider.of(context);
  LoginCubit() : super(LoginInitial());
  late String verificationId;
  int? _resendToken;
  FirebaseAuth auth = FirebaseAuth.instance;
  final CacheHelper prefs = instance<CacheHelper>();
  TextEditingController otpController = TextEditingController();
  //
  // Future<void> submitPhoneNumber(String phoneNumber) async {
  //   emit(PhoneAuthLoadingr());
  //   await auth.verifyPhoneNumber(
  //     phoneNumber: '${AppStrings.sudiaKey}$phoneNumber',
  //     timeout: const Duration(seconds: 60),
  //     verificationCompleted: (PhoneAuthCredential credential) async {
  //       await auth.signInWithCredential(credential);
  //     },
  //     verificationFailed: (FirebaseAuthException error) {
  //       emit(PhoneAuthErrorr(errorMsg: error.toString()));
  //     },
  //     codeSent: (String verificationId, int? resendToken) {
  //       this.verificationId = verificationId;
  //       _resendToken = resendToken;
  //       emit(PhoneNumberSubmitedr());
  //     },
  //     codeAutoRetrievalTimeout: (String verifyId) {},
  //   );
  // }
  //
  // Future<void> submitOTP(String otpCode) async {
  //   emit(PhoneOTPLoadingr());
  //   PhoneAuthCredential credential = PhoneAuthProvider.credential(
  //       verificationId: verificationId, smsCode: otpCode);
  //   await auth.signInWithCredential(credential);
  //   emit(PhoneOTPVerifiedr());
  // }
  //
  // Future<bool> sendOTP(String phoneNumber) async {
  //   await auth.verifyPhoneNumber(
  //     phoneNumber: '${AppStrings.sudiaKey}$phoneNumber',
  //     verificationCompleted: (PhoneAuthCredential credential) {},
  //     verificationFailed: (FirebaseAuthException e) {},
  //     codeSent: (String verificationId, int? resendToken) async {
  //       verificationId = verificationId;
  //       _resendToken = resendToken;
  //     },
  //     timeout: const Duration(seconds: 60),
  //     forceResendingToken: _resendToken,
  //     codeAutoRetrievalTimeout: (String verificationId) {
  //       verificationId = verificationId;
  //     },
  //   );
  //   debugPrint('verificationId: $verificationId');
  //   return true;
  // }

  int timerLeft = 60;
  bool isTimerFinished = false;
  Timer? timer;

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      timerLeft > 0 ? timerLeft-- : timerLeft;
      if (timerLeft == 0) {
        timer.cancel();
        isTimerFinished = true;
      }
      emit(PhoneAuthTimerChangedr(timer: timerLeft));
    });
  }

  void stopTimer() {
    timer?.cancel();
    timerLeft = 60;
    isTimerFinished = false;
    emit(PhoneAuthTimerChangedr(timer: timerLeft));
  }
  //
  // /// ========================================= LOGIN FIREBASE Cubit =========================================
  //
  // SendLoginUid? uidModel;
  // Future<void> sendLoginUid(
  //     {required String phone, required String uid}) async {
  //   emit(SendUidLoadingr());
  //   FormData formData = FormData.fromMap({'firebase_id': uid, 'phone': phone});
  //   await DioHelper.postData(url: EndPoints.sendUid, data: formData)
  //       .then((value) {
  //     uidModel = SendLoginUid.fromJson(value.data);
  //     saveLocal();
  //     emit(SendUidSuccessr(uidModel!));
  //   }).catchError((error) {
  //     emit(SendUidErrorr(error.toString()));
  //   });
  // }

  // void saveLocal() {
  //   prefs.save(key: 'token', value: uidModel!.data!.token);
  //   prefs.save(key: 'uid', value: uidModel!.data!.fireBaseId);
  //   prefs.save(key: 'userId', value: uidModel!.data!.id);
  // }

  String countryCode = '+966';
  void changeCountryCode(String code) {
    countryCode = code;
    AppStrings.sudiaKey = code;
    emit(PhoneCountryCodeChangedr(code));
  }
  /// ==================================================================================
  bool isChecked = true;
  void changeCheck() {
    isChecked = !isChecked;
    emit(PhoneTermsCheckChangedr());
  }

  final GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rEmailController = TextEditingController();
  TextEditingController rPasswordController = TextEditingController();
  TextEditingController phoneController =TextEditingController();
  TextEditingController nameController = TextEditingController();

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changeIcon() {
    isPassword = !isPassword;
    suffix =
    isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopLoginIsPassword());
  }

  String? validateEmail(String value) {
    if (value.isEmpty) {
      return 'email_must_not_be_empty';
    } else if (!value.contains('@')) {
      return 'email_must_be_valid';
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return 'password_must_not_be_empty';
    } else if (value.length < 8) {
      return 'password_must_be_more_than_8_characters';
    }
    return null;
  }
  //
  // LoginModel? loginModel;
  // Future<void> login() async {
  //   emit(LoginLoadingState());
  //   FormData data = FormData.fromMap({
  //     'email': emailController.text,
  //     'password': passwordController.text,
  //   });
  //   await DioHelper.postData(url: EndPoints.login, data: data).then((value) {
  //     loginModel = LoginModel.fromJson(value.data);
  //     emit(LoginSuccessState());
  //   }).catchError((error) {
  //     PrintLog.e(error.toString());
  //     emit(LoginErrorState(error));
  //   });
  // }

  RegisterModel? registerModel;
  Future<void> register() async {
    emit(LoginLoadingState());
    FormData data = FormData.fromMap({
      'name':nameController.text.toString() , // nameController.text,
      'email': emailController.text.toString(), // rEmailController.text,
      'phone':"+966${phoneController.text.toString()}", // phoneController.text,
      'password': passwordController.text.toString(), // rPasswordController.text,
    });

    print(emailController.toString());

    await DioHelper.postData(url: EndPoints.register, data: data).then((value) {
      PrintLog.i(value.data!.toString());
      registerModel = RegisterModel.fromJson(value.data);


      void savePhoneLocal() async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('phone', '+966${phoneController}');
      }
      emit(LoginSuccessState());
    }).catchError((error) {
      PrintLog.e(error.toString());
      emit(LoginErrorState(error));
    });
  }




//  RegisterModel? registerModel0;
  Future<void> activeAccountWithOTP() async {
    emit(LoginLoadingState());
    FormData data = FormData.fromMap({

      'phone': "+966${phoneController.toString()}",
      'code':  otpController.toString(),
      // ph // rPasswordController.text,
    });
    await DioHelper.postData(url: EndPoints.activateAccount, data: data).then((value) {
      PrintLog.i(value.data.toString());
    //  registerModel0 = RegisterModel.fromJson(value.data);


      emit(LoginSuccessState());
    }).catchError((error) {
      PrintLog.e(error.toString());
      emit(LoginErrorState(error));
    });
  }
}
