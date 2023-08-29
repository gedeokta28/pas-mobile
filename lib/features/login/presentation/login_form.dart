import 'package:flutter/material.dart';
import 'package:pas_mobile/core/presentation/update_fcm_token_provider.dart';
import 'package:pas_mobile/core/static/app_config.dart';
import 'package:pas_mobile/features/forgot_password/presentation/forgot_password_page.dart.dart';
import 'package:pas_mobile/features/register/presentation/register_page.dart';
import 'package:provider/provider.dart';

import '../../../core/presentation/pages/main_page/main_page.dart';
import '../../../core/presentation/widgets/custom_text_field.dart';
import '../../../core/presentation/widgets/rounded_button.dart';
import '../../../core/static/colors.dart';
import '../../../core/static/dimens.dart';
import '../../../core/utility/enum.dart';
import '../../../core/utility/helper.dart';
import '../../../core/utility/injection.dart';
import '../../../core/utility/validation_helper.dart';
import 'providers/login_provider.dart';
import 'providers/login_state.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _deviceTokenProvider = locator<DeviceTokenProvider>();

  void submit() {
    final provider = context.read<LoginProvider>();
    provider.doLoginApi().listen((state) async {
      switch (state.runtimeType) {
        case LoginFailure:
          showShortToast(message: "Periksa Email dan Password Anda");
          break;
        case LoginSuccess:
          _deviceTokenProvider.checkDeviceToken();
          Navigator.pushReplacementNamed(
              locator<GlobalKey<NavigatorState>>().currentContext!,
              MainPage.routeName);
          showShortToast(message: "Login Sukses");
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(
      builder: (context, provider, _) => Form(
        key: provider.formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: SIZE_MEDIUM,
          ),
          child: Column(
            children: [
              CustomTextField(
                title: "Email",
                controller: provider.emailController,
                inputType: TextInputType.emailAddress,
                fieldValidator: ValidationHelper(
                  loc: appLoc,
                  isError: (bool value) => provider.setEmailError = value,
                  typeField: TypeField.email,
                ).validate(),
              ),
              mediumVerticalSpacing(),
              CustomTextField(
                title: "Password",
                controller: provider.passwordController,
                inputType: TextInputType.visiblePassword,
                isSecure: true,
                fieldValidator: ValidationHelper(
                  loc: appLoc,
                  isError: (bool value) => provider.setPasswordError = value,
                  typeField: TypeField.password,
                ).validate(),
              ),
              largeVerticalSpacing(),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, ForgotPasswordPage.routeName);
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Lupa Password ?",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            fontSize: FONT_MEDIUM,
                            color: secondaryColor,
                            fontWeight: FontWeight.normal)),
                  ],
                ),
              ),
              largeVerticalSpacing(),
              RoundedButton(
                title: "Login",
                color: secondaryColor,
                event: () {
                  if (provider.formKey.currentState!.validate()) submit();
                },
              ),
              SizedBox(
                height: App(context).appHeight(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("Belum punya akun ?",
                        style: TextStyle(
                            fontSize: FONT_MEDIUM,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, RegisterPage.routeName);
                      },
                      child: Container(
                        color: Colors.transparent,
                        height: App(context).appHeight(10),
                        child: const Center(
                          child: Padding(
                            padding: EdgeInsets.only(left: 10, right: 15),
                            child: Text("Daftar",
                                style: TextStyle(
                                    fontSize: FONT_MEDIUM,
                                    color: secondaryColor,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              largeVerticalSpacing(),
            ],
          ),
        ),
      ),
    );
  }
}
