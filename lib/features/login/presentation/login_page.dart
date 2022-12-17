import 'package:flutter/material.dart';
import 'package:pas_mobile/core/static/assets.dart';
import 'package:provider/provider.dart';

import '../../../../core/presentation/pages/main_page/main_page.dart';
import '../../../core/presentation/widgets/custom_app_bar.dart';
import '../../../core/presentation/widgets/rounded_button.dart';
import '../../../core/static/app_config.dart';
import '../../../core/static/dimens.dart';
import '../../../core/utility/helper.dart';
import '../../../core/utility/injection.dart';
import 'login_form.dart';
import 'providers/login_provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({
    Key? key,
  }) : super(key: key);
  static const routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => locator<LoginProvider>(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          title: "Login",
          centerTitle: true,
          canBack: true,
          hideShadow: false,
        ),
        body: SafeArea(
          child: ListView(
            children: [
              AspectRatio(
                aspectRatio:
                    (App(context).appWidth(4) / App(context).appHeight(1.4)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      ASSETS_LOGIN,
                      width: App(context).appWidth(80),
                    ),
                  ],
                ),
              ),
              const LoginForm(),
              mediumVerticalSpacing(),
            ],
          ),
        ),
      ),
    );
  }
}
