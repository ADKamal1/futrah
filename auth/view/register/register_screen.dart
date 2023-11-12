// part of 'register_imports.dart';
//
// class RegisterScreen extends StatelessWidget {
//   const RegisterScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<LoginCubit, LoginState>(
//       listener: (context, state) {
//         var cubit = LoginCubit.get(context);
//
//         // if (state is RegisterSuccessState) {
//         //   navigateReplacement(context, route: Routes.company);
//         // }
//         if (cubit.registerModel!.errors != null) {
//           errorSnackBar(msg: cubit.registerModel!.errors.toString());
//         }
//         if (state is RegisterSuccessState ||
//             cubit.registerModel!.message == 'success') {
//           navigateReplacement(context, route: Routes.company);
//         }
//       },
//       child: BlocBuilder<LoginCubit, LoginState>(
//         builder: (context, state) {
//           var cubit = LoginCubit.get(context);
//           return CustomCondition(
//             state: state is! RegisterLoadingState,
//             body: Scaffold(
//               appBar: const CustomAppBar(title: LangBtn()),
//               body: Form(
//                 key: cubit.formKey,
//                 child: ListView(
//                   physics: const BouncingScrollPhysics(),
//                   padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
//                   children: [
//                     InkWell(
//                       onTap: () => cubit.register(),
//                       child: const AuthLogo(height: 150, width: 150),
//                     ),
//                     15.h,
//                     AuthTextFiled(
//                       controller: cubit.nameController,
//                       title: 'name'.tr(context),
//                       prefix: Icons.person,
//                       isPassword: false,
//                       keyboardType: TextInputType.name,
//                     ),
//                     10.h,
//                     AuthTextFiled(
//                       controller: cubit.rEmailController,
//                       title: 'email'.tr(context),
//                       prefix: Icons.email,
//                       isPassword: false,
//                       keyboardType: TextInputType.emailAddress,
//                       validator: (value) => cubit.validateEmail(value!),
//                     ),
//                     10.h,
//                     AuthTextFiled(
//                       controller: cubit.phoneController,
//                       title: 'phone'.tr(context),
//                       prefix: Icons.phone,
//                       isPassword: false,
//                       keyboardType: TextInputType.phone,
//                     ),
//                     10.h,
//                     AuthTextFiled(
//                       controller: cubit.rPasswordController,
//                       title: 'password'.tr(context),
//                       prefix: Icons.lock,
//                       isPassword: cubit.isPassword,
//                       keyboardType: TextInputType.visiblePassword,
//                       suffix: cubit.suffix,
//                       suffixPressed: () => cubit.changeIcon(),
//                       validator: (value) => cubit.validatePassword(value!),
//                       onSubmitted: (_) => registerPressed(context),
//                     ),
//                   ],
//                 ),
//               ),
//               bottomNavigationBar: AuthBtn(
//                 title: 'register'.tr(context),
//                 onTap: () => registerPressed(context),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   void registerPressed(BuildContext context) {
//     FocusScope.of(context).unfocus();
//     var cubit = LoginCubit.get(context);
//
//     if (cubit.formKey.currentState!.validate()) {
//       cubit.register();
//     } else {
//       errorSnackBar(msg: 'accept_terms&enter_number'.tr(context));
//     }
//   }
// }
