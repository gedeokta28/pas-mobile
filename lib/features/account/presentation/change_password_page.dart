import 'package:flutter/material.dart';
import 'package:pas_mobile/features/account/presentation/providers/management_account_provider.dart';
import 'package:pas_mobile/features/account/presentation/providers/update_profile_state.dart';
import 'package:provider/provider.dart';

import '../../../core/presentation/pages/main_page/main_page.dart';
import '../../../core/presentation/widgets/custom_app_bar.dart';
import '../../../core/presentation/widgets/custom_simple_dialog.dart';
import '../../../core/presentation/widgets/custom_text_field.dart';
import '../../../core/presentation/widgets/rounded_button.dart';
import '../../../core/static/colors.dart';
import '../../../core/static/dimens.dart';
import '../../../core/utility/enum.dart';
import '../../../core/utility/helper.dart';
import '../../../core/utility/injection.dart';
import '../../../core/utility/validation_helper.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({
    Key? key,
  }) : super(key: key);
  static const routeName = '/change-password';

  void submit() {
    logMe("Simpannn");
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => locator<ManagementAccountProvider>(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: const CustomAppBar(
          title: "Ubah Password",
          centerTitle: true,
          canBack: true,
          hideShadow: false,
        ),
        body: Consumer<ManagementAccountProvider>(
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
                    title: "Password Sekarang",
                    controller: provider.passwordController,
                    inputType: TextInputType.visiblePassword,
                    isSecure: true,
                    fieldValidator: ValidationHelper(
                      loc: appLoc,
                      isError: (bool value) =>
                          provider.setPasswordError = value,
                      typeField: TypeField.password,
                    ).validate(),
                  ),
                  smallVerticalSpacing(),
                  CustomTextField(
                    title: "Password Baru",
                    controller: provider.passwordNewController,
                    inputType: TextInputType.visiblePassword,
                    isSecure: true,
                    fieldValidator: (val) {
                      String pwdNew = val;
                      if (pwdNew.isEmpty) {
                        return 'Data ini tidak boleh kosong';
                      }

                      return null;
                    },
                  ),
                  smallVerticalSpacing(),
                  CustomTextField(
                    title: "Konfirmasi Password Baru",
                    controller: provider.passwordConfirmationController,
                    inputType: TextInputType.visiblePassword,
                    isSecure: true,
                    fieldValidator: (val) {
                      String pwdConfirm = val;
                      if (pwdConfirm.isEmpty) {
                        return 'Data ini tidak boleh kosong';
                      }
                      if (val != provider.passwordNewController.text) {
                        return 'Konfirmasi password tidak sesuai';
                      }
                      return null;
                    },
                  ),
                  mediumVerticalSpacing(),
                  RoundedButton(
                    title: "Simpan",
                    color: secondaryColor,
                    event: () {
                      if (provider.formKey.currentState!.validate()) {
                        Map<String, String> body = {
                          'old_password': provider.passwordController.text,
                          'new_password': provider.passwordNewController.text,
                          'new_password_confirmation':
                              provider.passwordConfirmationController.text,
                        };
                        provider.updateProfile(body).listen((event) {
                          if (event is UpdateProfileSuccess) {
                            showShortToast(message: event.data.message);

                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              MainPage.routeName,
                              (route) => false,
                              arguments: 3, // navbar index
                            );
                          } else if (event is UpdateProfileFailure) {
                            final msg = getErrorMessage(event.failure);
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) {
                                  return CustomSimpleDialog(
                                      text: msg,
                                      onTap: () {
                                        Navigator.pop(context);
                                      });
                                });
                          }
                        });
                      }
                    },
                  ),
                  largeVerticalSpacing(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
