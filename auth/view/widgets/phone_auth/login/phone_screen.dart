// part of 'phone_imports.dart';
//
// class PhoneAuthScreen extends StatefulWidget {
//   const PhoneAuthScreen({super.key});
//
//   @override
//   State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
// }
//
// class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
//   TextEditingController phoneController = TextEditingController();
//   final GlobalKey<FormState> formKey = GlobalKey();
//   @override
//   initState() {
//     super.initState();
//     var cubit = LoginCubit.get(context);
//     cubit.changeCountryCode('+966');
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<LoginCubit, PhoneAuthState>(
//       listenWhen: (previous, current) => previous != current,
//       listener: (context, state) {
//         if (state is PhoneAuthLoading) const AppLoading();
//         if (state is PhoneNumberSubmited) {
//           pushNamed(context, route: Routes.otp, args: phoneController.text);
//         }
//         if (state is PhoneAuthError) {
//           String errorMsg = (state).errorMsg;
//           errorSnackBar(msg: getErrorMessage(errorMsg));
//         }
//       },
//       child: BlocBuilder<LoginCubit, PhoneAuthState>(
//         builder: (context, state) {
//           var cubit = LoginCubit.get(context);
//           return CustomCondition(
//             state: state is! PhoneAuthLoading,
//             body: Form(
//               key: formKey,
//               child: Scaffold(
//                 appBar: const CustomAppBar(title: LangBtn()),
//                 body: ListView(
//                   physics: const BouncingScrollPhysics(),
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   children: [
//                     const AuthLogo(height: 250, width: 250),
//                     LoginTextFiled(
//                       controller: phoneController,
//                       onSubmit: (value) => loginPressed(context),
//                       onChanged: (code) => cubit.changeCountryCode(code),
//                     ),
//                     15.h,
//                     LoginTermsCheck(
//                       isChecked: cubit.isChecked,
//                       onChanged: (value) => cubit.changeCheck(),
//                     ),
//                   ],
//                 ),
//                 bottomNavigationBar: AuthBtn(
//                   title: 'login'.tr(context),
//                   onTap: () => loginPressed(context),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   void loginPressed(BuildContext context) {
//     var cubit = LoginCubit.get(context);
//     if (cubit.isChecked == true) {
//       if (formKey.currentState!.validate()) {
//         cubit.submitPhoneNumber(phoneController.text);
//       }
//       FocusScope.of(context).unfocus();
//     } else {
//       errorSnackBar(msg: 'accept_terms&enter_number'.tr(context));
//     }
//   }
// }
