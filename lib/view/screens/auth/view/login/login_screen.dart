part of 'login_imports.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phoneController = TextEditingController();

  String passController =" 11111111";
  final GlobalKey<FormState> formKey = GlobalKey();
  @override
  initState() {
    super.initState();
    var cubit = PhoneAuthCubit.get(context);
    cubit.changeCountryCode('+966');
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PhoneAuthCubit, PhoneAuthState>(
      listenWhen: (previous, current) => previous != current,
      listener: (context, state) {
        if (state is PhoneAuthLoading) const AppLoading();
        if (state is PhoneAuthSuccess) {
          pushNamed(context, route: Routes.company);
        }
        if (state is PhoneAuthError) {
          String errorMsg = (state).errorMsg;
          errorSnackBar(msg: getErrorMessage(errorMsg));
        }
      },
      child: BlocBuilder<PhoneAuthCubit, PhoneAuthState>(
        builder: (context, state) {
          var cubit = PhoneAuthCubit.get(context);
          return CustomCondition(
            state: state is! PhoneAuthLoading,
            body: Form(
              key: formKey,
              child: Scaffold(
                appBar: const CustomAppBar(title: LangBtn()),
                body: ListView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    const AuthLogo(height: 250, width: 250),
                    LoginTextFiled(
                      controller: phoneController,
                      onSubmit: (value) => loginPressed(context),
                      onChanged: (code) => cubit.changeCountryCode(code),
                    ),
                    15.h,
                    LoginTermsCheck(
                      isChecked: cubit.isChecked,
                      onChanged: (value) => cubit.changeCheck(),
                    ),
                  ],
                ),
                bottomNavigationBar: AuthBtn(
                  title: 'login'.tr(context),
                  onTap: () => loginPressed(context),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void loginPressed(BuildContext context) {
    var cubit = PhoneAuthCubit.get(context);
    if (cubit.isChecked == true) {
      if (formKey.currentState!.validate()) {
        cubit.submitPhoneNumber("+966 ${phoneController.text.toString()}",passController);
      }
      FocusScope.of(context).unfocus();
    } else {
      errorSnackBar(msg: 'accept_terms&enter_number'.tr(context));
    }
  }
}
