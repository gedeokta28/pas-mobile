import 'package:flutter/material.dart';
import 'package:pas_mobile/core/static/assets.dart';
import 'package:pas_mobile/features/account/presentation/providers/management_account_provider.dart';
import 'package:pas_mobile/features/category/presentation/providers/category_provider.dart';
import 'package:pas_mobile/features/category/presentation/providers/category_state.dart';
import 'package:pas_mobile/features/category/presentation/widgets/category_item.dart';
import 'package:pas_mobile/features/login/presentation/providers/login_provider.dart';
import 'package:provider/provider.dart';

import '../../../core/presentation/widgets/custom_app_bar.dart';
import '../../../core/presentation/widgets/custom_text_field.dart';
import '../../../core/presentation/widgets/custom_text_field_clear.dart';
import '../../../core/presentation/widgets/rounded_button.dart';
import '../../../core/static/colors.dart';
import '../../../core/static/dimens.dart';
import '../../../core/utility/enum.dart';
import '../../../core/utility/helper.dart';
import '../../../core/utility/injection.dart';
import '../../../core/utility/validation_helper.dart';
import '../../forgot_password/presentation/providers/forgot_password_provider.dart';
import '../../home/presentation/product_page.dart';
import '../../home/presentation/providers/home_provider.dart';

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
                      if (provider.formKey.currentState!.validate()) submit();
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
