import 'package:flutter/material.dart';
import 'package:pas_mobile/core/static/assets.dart';
import 'package:pas_mobile/features/account/presentation/providers/management_account_provider.dart';
import 'package:pas_mobile/features/account/presentation/providers/update_profile_state.dart';
import 'package:pas_mobile/features/category/presentation/providers/category_provider.dart';
import 'package:pas_mobile/features/category/presentation/providers/category_state.dart';
import 'package:pas_mobile/features/category/presentation/widgets/category_item.dart';
import 'package:pas_mobile/features/login/presentation/providers/login_provider.dart';
import 'package:provider/provider.dart';

import '../../../core/presentation/pages/main_page/main_page.dart';
import '../../../core/presentation/widgets/custom_app_bar.dart';
import '../../../core/presentation/widgets/custom_simple_dialog.dart';
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
import '../data/models/profile_model.dart';

class ChangeEmailPage extends StatelessWidget {
  final Profile profile;
  const ChangeEmailPage({
    required this.profile,
    Key? key,
  }) : super(key: key);
  static const routeName = '/change-email';

  void submit() {}

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          locator<ManagementAccountProvider>()..setProfileData(profile),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const CustomAppBar(
          title: "Ubah Email",
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
                  CustomClearTextField(
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
                  RoundedButton(
                    title: "Simpan",
                    color: secondaryColor,
                    event: () {
                      if (provider.formKey.currentState!.validate()) {
                        Map<String, String> body = {
                          'email': provider.emailController.text,
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
