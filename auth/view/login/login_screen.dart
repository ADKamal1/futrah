// part of 'login_imports.dart';
//
// class LoginScreen extends StatelessWidget {
//   const LoginScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<LoginCubit, LoginState>(
//       listener: (context, state) {
//         if (state is LoginSuccessState) {
//           navigateReplacement(context, route: Routes.home);
//         }
//       },
//       child: BlocBuilder<LoginCubit, LoginState>(
//         builder: (context, state) {
//           var cubit = LoginCubit.get(context);
//           return CustomCondition(
//             state: state is! LoginLoadingState,
//             body: Scaffold(
//               appBar: const CustomAppBar(title: LangBtn()),
//               body: Form(
//                 key: cubit.formKey,
//                 child: ListView(
//                   physics: const BouncingScrollPhysics(),
//                   padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
//                   children: [
//                     const AuthLogo(height: 200, width: 200),
//                     15.h,
//                     AuthTextFiled(
//                       controller: cubit.emailController,
//                       title: 'email'.tr(context),
//                       prefix: Icons.email,
//                       isPassword: false,
//                       keyboardType: TextInputType.emailAddress,
//                       validator: (value) => cubit.validateEmail(value!),
//                     ),
//                     10.h,
//                     AuthTextFiled(
//                       controller: cubit.passwordController,
//                       title: 'password'.tr(context),
//                       prefix: Icons.lock,
//                       isPassword: cubit.isPassword,
//                       keyboardType: TextInputType.visiblePassword,
//                       suffix: cubit.suffix,
//                       suffixPressed: () => cubit.changeIcon(),
//                       validator: (value) => cubit.validatePassword(value!),
//                       onSubmitted: (_) => loginPressed(context),
//                     ),
//                     15.h,
//                     LoginTermsCheck(
//                       isChecked: cubit.isChecked,
//                       onChanged: (value) => cubit.changeCheck(),
//                     ),
//                   ],
//                 ),
//               ),
//               bottomNavigationBar: AuthBtn(
//                 title: 'login'.tr(context),
//                 onTap: () => loginPressed(context),
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
//       if (cubit.formKey.currentState!.validate()) {
//         cubit.login();
//       }
//     } else {
//       errorSnackBar(msg: 'accept_terms&enter_number'.tr(context));
//     }
//   }
// }
