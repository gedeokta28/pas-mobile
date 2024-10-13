import 'package:flutter/material.dart';
import 'package:pas_mobile/core/presentation/update_fcm_token_provider.dart';
import 'package:pas_mobile/core/utility/extensions.dart';
import 'package:pas_mobile/features/login/presentation/login_page.dart';
import 'package:pas_mobile/features/register/presentation/custom_dropdown.dart';
import 'package:pas_mobile/features/register/presentation/providers/register_provider.dart';
import 'package:pas_mobile/features/register/presentation/providers/register_state.dart';
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

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _deviceTokenProvider = locator<DeviceTokenProvider>();

  void submit() {
    final provider = context.read<RegisterProvider>();
    provider.doRegisterApi().listen((state) async {
      switch (state.runtimeType) {
        case RegisterFailure:
          final msg = getErrorMessage((state as RegisterFailure).failure);
          showShortToast(message: msg);
          break;
        case RegisterSuccess:
          _deviceTokenProvider.checkDeviceToken();
          Navigator.pushReplacementNamed(
              locator<GlobalKey<NavigatorState>>().currentContext!,
              MainPage.routeName);
          showShortToast(message: "Register Sukses");
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RegisterProvider>(
      builder: (context, provider, _) => Form(
        key: provider.formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: SIZE_MEDIUM,
          ),
          child: Column(
            children: [
              largeVerticalSpacing(),
              CustomTextField(
                title: "Nama",
                controller: provider.usernameController,
                inputType: TextInputType.text,
                fieldValidator: ValidationHelper(
                  loc: appLoc,
                  isError: (bool value) => provider.setUsernameError = value,
                  typeField: TypeField.none,
                ).validate(),
              ),
              mediumVerticalSpacing(),
              CustomDropdownButtonWidget(
                value: provider.dropdownValue,
                items: <String>[
                  AccountType.personal.getValue(),
                  AccountType.company.getValue(),
                ].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(value == AccountType.personal.getValue()
                            ? AccountType.personal.toStrings()
                            : AccountType.company.toStrings()),
                        const Divider(),
                      ],
                    ),
                  );
                }).toList(),
                onChange: (value) {
                  provider.dropdownValue = value;
                },
                selectedItemWidget: (context) {
                  return <String>[
                    AccountType.personal.toStrings(),
                    AccountType.company.toStrings()
                  ].map((String value) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Text(
                        provider.dropdownValue ==
                                AccountType.personal.getValue()
                            ? AccountType.personal.toStrings()
                            : AccountType.company.toStrings(),
                        style:
                            const TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    );
                  }).toList();
                },
              ),
              mediumVerticalSpacing(),
              CustomTextField(
                title: "No. KTP",
                controller: provider.ktpController,
                inputType: TextInputType.number,
                fieldValidator: ValidationHelper(
                  loc: appLoc,
                  isError: (bool value) => provider.setUsernameError = value,
                  typeField: TypeField.none,
                ).validate(),
              ),
              mediumVerticalSpacing(),
              CustomTextField(
                title: "NPWP",
                controller: provider.npwpController,
                inputType: TextInputType.number,
                fieldValidator: null,
              ),
              mediumVerticalSpacing(),
              CustomTextField(
                title: "Kontak Person",
                controller: provider.contactPersonController,
                inputType: TextInputType.text,
                fieldValidator: ValidationHelper(
                  loc: appLoc,
                  isError: (bool value) => provider.setEmailError = value,
                  typeField: TypeField.none,
                ).validate(),
              ),
              mediumVerticalSpacing(),
              CustomTextField(
                title: "No. Telpon",
                controller: provider.phoneNumberController,
                inputType: TextInputType.phone,
                fieldValidator: ValidationHelper(
                  loc: appLoc,
                  isError: (bool value) => provider.setUsernameError = value,
                  typeField: TypeField.none,
                ).validate(),
              ),
              mediumVerticalSpacing(),
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
                  typeField: TypeField.none,
                ).validate(),
              ),
              largeVerticalSpacing(),
              RoundedButton(
                title: "Daftar",
                color: secondaryColor,
                event: () {
                  if (provider.formKey.currentState!.validate()) submit();
                },
              ),
              largeVerticalSpacing(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Sudah punya akun ?",
                      style: TextStyle(
                          fontSize: FONT_MEDIUM,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                  smallHorizontalSpacing(),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, LoginPage.routeName);
                    },
                    child: const Text("Masuk",
                        style: TextStyle(
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
      ),
    );
  }
}
