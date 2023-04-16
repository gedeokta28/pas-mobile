import 'package:flutter/material.dart';
import 'package:pas_mobile/core/presentation/pages/main_page/main_page.dart';
import 'package:pas_mobile/features/account/data/models/get_address_model.dart';
import 'package:pas_mobile/features/account/data/models/profile_model.dart';
import 'package:pas_mobile/features/account/presentation/change_email_page.dart';
import 'package:pas_mobile/features/account/presentation/change_password_page.dart';
import 'package:pas_mobile/features/account/presentation/change_personal_info_page.dart';
import 'package:pas_mobile/features/account/presentation/change_username_page.dart';
import 'package:pas_mobile/features/account/presentation/create_address_page.dart';
import 'package:pas_mobile/features/account/presentation/update_address_page.dart';
import 'package:pas_mobile/features/cart/presentation/cart_page.dart';
import 'package:pas_mobile/features/category/presentation/category_page.dart';
import 'package:pas_mobile/features/filter/presentation/filter_page.dart';
import 'package:pas_mobile/features/forgot_password/presentation/forgot_password_page.dart.dart';
import 'package:pas_mobile/features/home/presentation/product_page.dart';
import 'package:pas_mobile/features/login/presentation/login_page.dart';
import 'package:pas_mobile/features/notification/presentation/notif_page.dart';
import 'package:pas_mobile/features/order/presentation/checkout_page.dart';
import 'package:pas_mobile/features/order/presentation/select_checkout_address_page.dart';
import 'package:pas_mobile/features/product/presentation/product_detail_page.dart';
import 'package:pas_mobile/features/register/presentation/register_page.dart';
import '../../features/order/presentation/order_detail_page.dart';
import '../../features/product/presentation/search_result_page.dart';
import '../../features/search/presentation/pages/search_page.dart';
import '../presentation/pages/splash_page.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashPage.routeName:
      return MaterialPageRoute(builder: (_) => const SplashPage());
    case LoginPage.routeName:
      return MaterialPageRoute(builder: (_) => const LoginPage());
    case ChangeUsernamePage.routeName:
      final args = settings.arguments as Profile;
      return MaterialPageRoute(
          builder: (_) => ChangeUsernamePage(
                profile: args,
              ));
    case ChangeEmailPage.routeName:
      final args = settings.arguments as Profile;
      return MaterialPageRoute(
          builder: (_) => ChangeEmailPage(
                profile: args,
              ));
    case ChangePasswordPage.routeName:
      return MaterialPageRoute(builder: (_) => const ChangePasswordPage());
    case ChangePersonalInfoPage.routeName:
      final args = settings.arguments as ChangePersonalInfoPageArguments;
      return MaterialPageRoute(
          builder: (_) => ChangePersonalInfoPage(
                profile: args.profile,
              ));
    case CreateAddressPage.routeName:
      return MaterialPageRoute(builder: (_) => const CreateAddressPage());
    case UpdateAddressPage.routeName:
      final args = settings.arguments as ShippingAddress;
      return MaterialPageRoute(
          builder: (_) => UpdateAddressPage(
                shippingAddress: args,
              ));
    case RegisterPage.routeName:
      return MaterialPageRoute(builder: (_) => const RegisterPage());
    case CategoryPage.routeName:
      return MaterialPageRoute(builder: (_) => const CategoryPage());
    case SearchPage.routeName:
      return MaterialPageRoute(builder: (_) => const SearchPage());
    case CartPage.routeName:
      return MaterialPageRoute(builder: (_) => const CartPage());
    case CheckoutPage.routeName:
      return MaterialPageRoute(builder: (_) => const CheckoutPage());
    // case AddressCheckoutPage.routeName:
    //   return MaterialPageRoute(builder: (_) => const AddressCheckoutPage());
    case OrderDetailPage.routeName:
      final args = settings.arguments as OrderDetailPageArguments;
      return MaterialPageRoute(
          builder: (_) => OrderDetailPage(
                isFromCheckout: args.isFromCheckout,
                orderId: args.orderId,
              ));
    case MainPage.routeName:
      final index = settings.arguments as int?;
      return MaterialPageRoute(
          builder: (_) => MainPage(
                index: index,
              ));
    case NotificationPage.routeName:
      return MaterialPageRoute(builder: (_) => const NotificationPage());
    case ProductPage.routeName:
      if (settings.arguments != null) {
        final args = settings.arguments as ProductPageArguments;
        return MaterialPageRoute(
            builder: (_) => ProductPage(
                  categoryId: args.categoryId,
                  brandId: args.brandId,
                  productPageParams: args.productPageParams,
                  brandName: args.brandName,
                  categoryName: args.categoryName,
                ));
      } else {
        return MaterialPageRoute(builder: (_) => const ProductPage());
      }

    case ForgotPasswordPage.routeName:
      return MaterialPageRoute(builder: (_) => const ForgotPasswordPage());
    case FilterPage.routeName:
      return MaterialPageRoute(builder: (_) => const FilterPage());
    case SearchResultPage.routeName:
      return MaterialPageRoute(builder: (_) => const SearchResultPage());
    case ProductDetailPage.routeName:
      final args = settings.arguments as ProductDetailArguments;
      return MaterialPageRoute(
          builder: (_) => ProductDetailPage(
                productId: args.productId,
                categoryId: args.categoryId,
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
