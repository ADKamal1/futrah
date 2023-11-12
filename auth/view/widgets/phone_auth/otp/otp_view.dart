// // ignore_for_file: use_build_context_synchronously
//
// part of 'otp_imports.dart';
//
// class OtpScreen extends StatefulWidget {
//   final String phoneNumber;
//
//   const OtpScreen({super.key, required this.phoneNumber});
//
//   @override
//   State<OtpScreen> createState() => _OtpScreenState();
// }
//
// class _OtpScreenState extends State<OtpScreen> {
//   late String otpCode;
//
//   @override
//   void initState() {
//     BlocProvider.of<LoginCubit>(context).startTimer();
//     Future.delayed(const Duration(milliseconds: 50), () {
//       FocusScope.of(context).requestFocus(FocusNode());
//     });
//     super.initState();
//   }
//
//   Future<void> _login(BuildContext context) async {
//     var cubit = LoginCubit.get(context);
//     await cubit.submitOTP(otpCode).then((value) async {
//       await cubit.sendLoginUid(
//         uid: FirebaseAuth.instance.currentUser!.uid,
//         phone: widget.phoneNumber,
//       );
//
//       savePhoneLocal();
//       if (cubit.uidModel!.message == 'success') {
//         save();
//         cubit.stopTimer();
//         pushReplacementNamed(context, route: Routes.company);
//       } else if (cubit.uidModel!.message == 'already user') {
//         save();
//         cubit.stopTimer();
//         pushReplacementNamed(context, route: Routes.home);
//       }
//     });
//     if (cubit.uidModel!.code != 200) {
//       errorSnackBar(msg: '${cubit.uidModel?.message}');
//     }
//   }
//
//   void save() {
//     final CacheHelper prefs = instance<CacheHelper>();
//     AppStrings.loginToken = prefs.get(key: 'token') ?? '';
//     AppStrings.userPhone = prefs.get(key: 'phone') ?? '';
//     AppStrings.userUid = prefs.get(key: 'uid') ?? '';
//     AppStrings.userId = prefs.get(key: 'userId') ?? 0;
//   }
//
//   void savePhoneLocal() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setString('phone', '${AppStrings.sudiaKey}${widget.phoneNumber}');
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<LoginCubit, PhoneAuthState>(
//       listenWhen: (previous, current) => previous != current,
//       listener: (context, state) {
//         if (state is PhoneAuthError) {
//           String errorMsg = (state).errorMsg;
//           errorSnackBar(msg: getErrorMessage(errorMsg));
//         }
//         if (state is PhoneOTPLoading) const AppLoading();
//         if (state is SendUidLoading) const AppLoading();
//       },
//       child: BlocBuilder<LoginCubit, PhoneAuthState>(
//         builder: (context, state) {
//           var cubit = LoginCubit.get(context);
//           final String resendTimerText =
//               '${'didnt_receive'.tr(context)}${'resend'.tr(context)}${cubit.timerLeft} ${'second'.tr(context)}';
//           return Scaffold(
//             appBar: const CustomAppBar(),
//             body: CustomCondition(
//               state: state is! PhoneOTPLoading && state is! SendUidLoading,
//               body: SingleChildScrollView(
//                 physics: const BouncingScrollPhysics(),
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       OtpHeader(phone: widget.phoneNumber),
//                       20.h,
//                       PinCodeFields(
//                         onCompleted: (submitedCode) {
//                           otpCode = submitedCode;
//                           if (otpCode.length == 6) {
//                             _login(context);
//                             hintSnackBar(msg: 'wait_verifying'.tr(context));
//                           }
//                         },
//                       ),
//                       15.h,
//                       FittedBox(
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Row(
//                             children: [
//                               state is PhoneOTPVerified
//                                   ? const SizedBox.shrink()
//                                   : InkWell(
//                                       onTap: cubit.timerLeft == 0
//                                           ? () {
//                                               cubit.sendOTP(widget.phoneNumber);
//                                               cubit.otpController.clear();
//                                               setState(() {
//                                                 cubit.timerLeft = 60;
//                                                 cubit.startTimer();
//                                                 successSnackBar(
//                                                     msg: 'otp_resend_success'
//                                                         .tr(context));
//                                               });
//                                             }
//                                           : null,
//                                       child: MyText(
//                                         title: cubit.timerLeft == 0
//                                             ? 'resend'.tr(context)
//                                             : resendTimerText,
//                                         size: 17,
//                                       ),
//                                     ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             bottomNavigationBar: AuthBtn(
//               title: 'confirm_verify'.tr(context),
//               onTap: () => _login(context),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
