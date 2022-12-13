import 'package:flutter/material.dart';
import 'package:pas_mobile/features/register/presentation/register_page.dart';
import 'package:provider/provider.dart';

import '../../../core/presentation/widgets/custom_text_field.dart';
import '../../../core/presentation/widgets/rounded_button.dart';
import '../../../core/static/colors.dart';
import '../../../core/static/dimens.dart';
import '../../../core/utility/helper.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();

  // void submit() {
  //   provider.doLoginApi().listen((state) async {
  //     switch (state.runtimeType) {
  //       case LoginLoading:
  //         loader.show();
  //         break;
  //       case LoginFailure:
  //         loader.hide();
  //         // final msg = getLoginMessageError((state as LoginFailure).statusCode);
  //         final msg = getErrorMessage((state as LoginFailure).failure);

  //         showShortToast(message: msg);
  //         break;
  //       case LoginSuccess:
  //         final session = locator<Session>();
  //         final _data = (state as LoginSuccess).data;
  //         loader.hide();

  //         if (_data.isVerified) {
  //           session.setToken = _data.token;
  //           session.setLoggedIn = true;
  //           Navigator.pushReplacementNamed(
  //               locator<GlobalKey<NavigatorState>>().currentContext!,
  //               Routing.MAIN);
  //           showShortToast(message: appLoc.successLogin);
  //         } else {
  //           Navigator.pushNamed(
  //             locator<GlobalKey<NavigatorState>>().currentContext!,
  //             Routing.VERIFICATION_PHONE,
  //             arguments: SmsVerificationPageRouteArguments(
  //               appBarTitle: appLoc.authenticatePhone,
  //               buttonTitle: appLoc.btnConfirmation,
  //               descriptionTextTop: appLoc.msgOnSmsVerificationAfterRegister,
  //               phoneNumber: convertPhoneNumber(provider.phoneController.text),
  //               token: _data.token,
  //               callBack: (_) {
  //                 session.setToken = _data.token;
  //                 session.setLoggedIn = true;
  //                 Navigator.pushReplacementNamed(
  //                     locator<GlobalKey<NavigatorState>>().currentContext!,
  //                     Routing.MAIN);
  //                 showShortToast(message: appLoc.successLogin);
  //               },
  //               type: OtpType.register,
  //             ),
  //           );
  //         }

  //         break;
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: GlobalKey<FormState>(),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: SIZE_MEDIUM,
        ),
        child: Column(
          children: [
            CustomTextField(
                title: "Email",
                controller: _emailController,
                inputType: TextInputType.emailAddress,
                fieldValidator: (val) {
                  if (val.isEmpty) {
                    return "Required";
                  }
                }),
            mediumVerticalSpacing(),
            CustomTextField(
                title: "Password",
                controller: _pwController,
                inputType: TextInputType.visiblePassword,
                isSecure: true,
                fieldValidator: (val) {
                  if (val.isEmpty) {
                    return "Required";
                  }
                }),
            largeVerticalSpacing(),
            InkWell(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Lupa Password ?",
                      textAlign: TextAlign.end,
                      style: const TextStyle(
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
              event: () {},
            ),
            largeVerticalSpacing(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Belum punya akun ?",
                    style: const TextStyle(
                        fontSize: FONT_MEDIUM,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
                smallHorizontalSpacing(),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacementNamed(
                        context, RegisterPage.routeName);
                  },
                  child: Text("Daftar",
                      style: const TextStyle(
                          fontSize: FONT_MEDIUM,
                          color: secondaryColor,
                          fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            largeVerticalSpacing(),
          ],
        ),
      ),
    );
  }
}
