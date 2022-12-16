import 'package:flutter/material.dart';
import 'package:pas_mobile/core/presentation/pages/main_page/main_page.dart';
import 'package:pas_mobile/features/cart/presentation/cart_page.dart';
import 'package:pas_mobile/features/category/presentation/category_page.dart';
import 'package:pas_mobile/features/home/data/models/product_list_response_model.dart';
import 'package:pas_mobile/features/login/presentation/login_page.dart';
import 'package:pas_mobile/features/notification/presentation/notif_page.dart';
import 'package:pas_mobile/features/product/presentation/product_page.dart';
import 'package:pas_mobile/features/register/presentation/register_page.dart';

import '../../features/search/presentation/pages/search_page.dart';
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
    case SearchPage.routeName:
      return MaterialPageRoute(builder: (_) => const SearchPage());
    case CartPage.routeName:
      return MaterialPageRoute(builder: (_) => const CartPage());
    case NotificationPage.routeName:
      return MaterialPageRoute(builder: (_) => const NotificationPage());
    case ProductDetailPage.routeName:
      final product = settings.arguments as Product;
      return MaterialPageRoute(
          builder: (_) => ProductDetailPage(product: product));
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
