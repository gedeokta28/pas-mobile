import 'package:flutter/material.dart';
import 'package:pas_mobile/core/static/assets.dart';
import 'package:pas_mobile/features/register/presentation/providers/register_provider.dart';
import 'package:pas_mobile/features/register/presentation/register_form.dart';
import 'package:provider/provider.dart';

import '../../../../core/presentation/pages/main_page/main_page.dart';
import '../../../core/presentation/widgets/custom_app_bar.dart';
import '../../../core/presentation/widgets/rounded_button.dart';
import '../../../core/static/dimens.dart';
import '../../../core/utility/helper.dart';
import '../../../core/utility/injection.dart';
import 'forgot_password_form.dart';
import 'providers/forgot_password_provider.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({
    Key? key,
  }) : super(key: key);
  static const routeName = '/forgot-password';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => locator<ForgotPasswordProvider>(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const CustomAppBar(
          title: "Forgot Password",
          centerTitle: true,
          canBack: true,
          hideShadow: false,
        ),
        body: SafeArea(
          child: ListView(
            children: [
              const ForgotPasswordForm(),
              mediumVerticalSpacing(),
            ],
          ),
        ),
      ),
    );
  }
}
