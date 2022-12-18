import 'package:flutter/material.dart';
import 'package:pas_mobile/core/presentation/widgets/custom_simple_dialog.dart';
import 'package:pas_mobile/features/login/presentation/login_page.dart';
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
import 'providers/forgot_password_provider.dart';
import 'providers/forgot_password_state.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  void submit() {
    final provider = context.read<ForgotPasswordProvider>();
    provider.doForgotPasswordApi().listen((state) async {
      switch (state.runtimeType) {
        case ForgotPasswordFailure:
          final msg = getErrorMessage((state as ForgotPasswordFailure).failure);
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
          ;
          break;
        case ForgotPasswordSuccess:
          // showShortToast(message: "Forgot Password Sukses");
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return CustomSimpleDialog(
                    text: 'Forgot Password Sukses \n Periksa Email Anda',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    });
              });
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ForgotPasswordProvider>(
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
                title: "Email",
                controller: provider.emailController,
                inputType: TextInputType.emailAddress,
                fieldValidator: ValidationHelper(
                  loc: appLoc,
                  isError: (bool value) => provider.setEmailError = value,
                  typeField: TypeField.email,
                ).validate(),
              ),
              largeVerticalSpacing(),
              RoundedButton(
                title: "Send",
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
    );
  }
}
