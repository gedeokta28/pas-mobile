import 'package:flutter/material.dart';
import 'package:pas_mobile/core/presentation/pages/main_page/main_page.dart';
import 'package:pas_mobile/features/category/presentation/category_page.dart';
import 'package:pas_mobile/features/login/presentation/login_page.dart';
import 'package:pas_mobile/features/register/presentation/register_page.dart';

import '../presentation/pages/splash_page.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashPage.routeName:
      return MaterialPageRoute(builder: (_) => const SplashPage());
    case LoginPage.routeName:
      return MaterialPageRoute(builder: (_) => const LoginPage());
    case RegisterPage.routeName:
      return MaterialPageRoute(builder: (_) => const RegisterPage());
    case CategoryPage.routeName:
      return MaterialPageRoute(builder: (_) => const CategoryPage());
    case MainPage.routeName:
      final index = settings.arguments as int?;
      return MaterialPageRoute(
          builder: (_) => MainPage(
                index: index,
              ));
    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        ),
      );
  }
}
