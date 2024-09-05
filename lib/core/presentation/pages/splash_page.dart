import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pas_mobile/core/presentation/pages/main_page/main_page.dart';
import 'package:pas_mobile/core/static/colors.dart';
import 'package:pas_mobile/core/utility/app_settings.dart';

import '../../static/assets.dart';
import '../../utility/helper.dart';
import '../../utility/injection.dart';
import '../../utility/session_helper.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);
  static const routeName = '/splash';

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () async {
      final session = locator<Session>();
      session.setIndexTab = 0;
      session.setCustomerId = '';
      session.setCustomerName = '';
      session.setSalesId = '';
      Navigator.pushReplacementNamed(context, MainPage.routeName);
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    appLoc = AppLocalizations.of(context)!;
    myLocale = Localizations.localeOf(context);
    sessionHelper = locator<Session>();

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image:
                AssetImage(splashBackground), // Path to your background image
            fit: BoxFit.fill, // Ensures the image covers the entire screen
          ),
        ),
        child: Center(
          child: Image.asset(
            newAppLogo, // Path to your logo image
            width: 150.0, // Adjust the size of the logo as needed
            height: 150.0,
          ),
        ),
      ),
    );
  }
}
