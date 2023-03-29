import 'package:flutter/material.dart';
import 'package:pas_mobile/core/static/app_config.dart';
import 'package:pas_mobile/core/static/assets.dart';
import 'package:pas_mobile/core/static/colors.dart';
import 'package:pas_mobile/features/cart/presentation/providers/add_cart_state.dart';
import 'package:pas_mobile/features/order/presentation/widgets/checkout_address_widget.dart';
import 'package:pas_mobile/features/order/presentation/widgets/checkout_item.dart';
import 'package:pas_mobile/features/order/presentation/widgets/checkout_noted_widget.dart';
import 'package:pas_mobile/features/order/presentation/widgets/payment_method_widget.dart';
import 'package:provider/provider.dart';

import '../../../core/presentation/widgets/custom_app_bar.dart';
import '../../../core/static/dimens.dart';
import '../../../core/utility/helper.dart';
import '../../../core/utility/injection.dart';
import '../../cart/presentation/providers/cart_provider.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({
    Key? key,
  }) : super(key: key);
  static const routeName = '/checkout';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => locator<CartProvider>()..createItem(),
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: Consumer<CartProvider>(
                  builder: (BuildContext context, provider, widget) {
                return CustomAppBar(
                  onTapBack: () {
                    if (provider.cartItemUpdated.isEmpty) {
                      Navigator.pop(context);
                    } else {
                      showLoading();
                      for (var i = 0;
                          i < provider.cartItemUpdated.length;
                          i++) {
                        provider
                            .updateProductCart(
                                itemId: provider.cartItemUpdated[i].id!,
                                qty: provider.cartItemUpdated[i].quantity!
                                    .toString())
                            .listen((event) {
                          if (event is AddToCartSuccess) {
                            if (i == (provider.cartItemUpdated.length - 1)) {
                              dismissLoading();
                              Navigator.pop(context);
                            }
                          }
                        });
                      }
                    }
                  },
                  title: "Checkout",
                  centerTitle: true,
                  canBack: true,
                  hideShadow: false,
                );
              })),
          body: Consumer<CartProvider>(
              builder: (BuildContext context, provider, widget) {
            if (provider.isLoadCart) {
              return Center(
                child: Image.asset(
                  ASSETS_LOADING,
                  height: 100.0,
                  width: 100.0,
                ),
              );
            } else {
              if (provider.cart.isEmpty) {
                return const Center(
                    child: Text(
                  'Keranjang Anda Kosong',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                ));
              }
              final ValueNotifier<int?> totalPrice = ValueNotifier(null);
              for (var element in provider.cart) {
                totalPrice.value =
                    (element.productPrice!.value * element.quantity!.value) +
                        (totalPrice.value ?? 0);
              }
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Consumer<CartProvider>(
                        builder: (BuildContext context, provider, widget) {
                          return ListView.builder(
                              shrinkWrap: true,
                              itemCount: provider.cart.length,
                              itemBuilder: (context, index) {
                                return CheckoutItem(index: index);
                              });
                        },
                      ),
                      Divider(
                        color: Colors.grey[400],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: FONT_GENERAL,
                                color: Colors.black54),
                          ),
                          Text(
                            'Rp. ${convertPrice(totalPrice.value.toString())}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: FONT_GENERAL,
                                color: Colors.black54),
                          ),
                        ],
                      ),
                      mediumVerticalSpacing(),
                      const PaymentMethodWidget(),
                      mediumVerticalSpacing(),
                      const CheckoutAddressWidget(),
                      mediumVerticalSpacing(),
                      const CheckoutNotedWidget()
                    ],
                  ),
                ),
              );
            }
          }),
          bottomNavigationBar: Consumer<CartProvider>(
              builder: (BuildContext context, provider, widget) {
            if (provider.cart.isEmpty) {
              return Container(
                height: 0,
              );
            } else {
              return InkWell(
                onTap: () async {
                  // logMe(provider.cartItemUpdated[0].quantity);
                  // showLoading();
                  // for (var i = 0; i < provider.cartItemUpdated.length; i++) {
                  //   provider
                  //       .updateProductCart(
                  //           itemId: provider.cartItemUpdated[i].id!,
                  //           qty: provider.cartItemUpdated[i].quantity!
                  //               .toString())
                  //       .listen((event) {
                  //     if (event is AddToCartSuccess) {
                  //       if (i == (provider.cartItemUpdated.length - 1)) {
                  //         dismissLoading();
                  //       }
                  //     }
                  //   });
                  // }
                },
                child: Container(
                  color: secondaryColor,
                  alignment: Alignment.center,
                  height: App(context).appHeight(8),
                  child: const Text(
                    'Place Order',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            }
          })),
    );
  }
}
