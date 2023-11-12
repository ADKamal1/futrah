part of 'register_imports.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        var cubit = LoginCubit.get(context);

        // if (state is RegisterSuccessState) {
        //   navigateReplacement(context, route: Routes.company);
        // }

        if (state is LoginSuccessState) {
          Navigator.of(context).pushReplacementNamed(
            Routes.otp,
            arguments:'+966${cubit.phoneController.text.toString()}' ,
          );
        }

      },
      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          var cubit = LoginCubit.get(context);

          return CustomCondition(
            state: state is! RegisterLoadingState,
            body: Scaffold(
              appBar: const CustomAppBar(title: LangBtn()),
              body: Form(
                key: cubit.formKey,
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  children: [
                    InkWell(
                      onTap: () => cubit.register(),
                      child: const AuthLogo(height: 150, width: 150),
                    ),
                    15.h,
                    AuthTextFiled(
                      controller: cubit.nameController,
                      title: 'name'.tr(context),
                      prefix: Icons.person,
                      isPassword: false,
                      keyboardType: TextInputType.name,
                    ),
                    10.h,
                    AuthTextFiled(
                      controller: cubit.emailController,
                      title: 'email'.tr(context),
                      prefix: Icons.email,
                      isPassword: false,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) => cubit.validateEmail(value!),
                    ),
                    10.h,


                    TextFormField(
                      textDirection: TextDirection.ltr,
                      controller: cubit.phoneController,
                      autofocus: true,
                      keyboardType: TextInputType.phone,
                      cursorColor: Colors.black,
                      style: const TextStyle(
                        fontSize: 18,
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w800,
                      ),
                      decoration: inputDecoration(
                        prefixIcon: CountryCodePicker(
                          initialSelection: '+966',
                          favorite: const ['+966', 'SA'],
                          showCountryOnly: true,
                          showOnlyCountryWhenClosed: false,
                          alignLeft: false,
                        ),
                      ),
                      // validator: (String? value) {
                      //   if (value!.isEmpty) {
                      //     return 'phone_number_required'.tr(context);
                      //   } else if (value.length < 9) {
                      //     return 'phone_number_smaller'.tr(context);
                      //   } else if (value.length > 9) {
                      //     return 'phone_number_bigger'.tr(context);
                      //   }
                      //   return null;
                      // },
                      onFieldSubmitted: (_) => registerPressed(context) ,
                    ),

                    // AuthTextFiled(
                    //   controller:cubit.phoneController,
                    //   title: 'phone'.tr(context),
                    //   prefix: Icons.phone,
                    //   isPassword: false,
                    //   keyboardType: TextInputType.phone,
                    // ),
                    10.h,
                    AuthTextFiled(
                      controller: cubit.passwordController,
                      title: 'password'.tr(context),
                      prefix: Icons.lock,
                      isPassword: cubit.isPassword,
                      keyboardType: TextInputType.visiblePassword,
                      suffix: cubit.suffix,
                      suffixPressed: () => cubit.changeIcon(),
                      validator: (value) => cubit.validatePassword(value!),
                      onSubmitted: (_) => registerPressed(context),
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: AuthBtn(
                title: 'register'.tr(context),
                onTap: () => registerPressed(context),
              ),
            ),
          );
        },
      ),
    );
  }

  void registerPressed(BuildContext context) {
    FocusScope.of(context).unfocus();
    var cubit = LoginCubit.get(context);

    if (cubit.formKey.currentState!.validate()) {
      cubit.register();
    } else {
      errorSnackBar(msg: 'accept_terms&enter_number'.tr(context));
    }
  }
}
