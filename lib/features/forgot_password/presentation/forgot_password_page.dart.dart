import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/presentation/widgets/custom_app_bar.dart';
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
