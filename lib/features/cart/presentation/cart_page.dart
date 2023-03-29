import 'package:flutter/material.dart';
import 'package:pas_mobile/core/static/app_config.dart';
import 'package:pas_mobile/core/static/assets.dart';
import 'package:pas_mobile/core/static/colors.dart';
import 'package:pas_mobile/features/cart/presentation/providers/add_cart_state.dart';
import 'package:pas_mobile/features/cart/presentation/widgets/cart_item.dart';
import 'package:pas_mobile/features/order/presentation/checkout_page.dart';
import 'package:provider/provider.dart';

import '../../../../core/presentation/pages/main_page/main_page.dart';
import '../../../core/presentation/widgets/custom_app_bar.dart';
import '../../../core/presentation/widgets/rounded_button.dart';
import '../../../core/static/dimens.dart';
import '../../../core/utility/helper.dart';
import '../../../core/utility/injection.dart';
import 'providers/cart_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({
    Key? key,
  }) : super(key: key);
  static const routeName = '/cart';

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
                  title: "Keranjang",
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

              return Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding:
                          EdgeInsets.only(left: 15.0, top: 15.0, bottom: 5.0),
                      child: Text(
                        "Order Review",
                        style: TextStyle(
                            fontSize: FONT_GENERAL,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Consumer<CartProvider>(
                      builder: (BuildContext context, provider, widget) {
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: provider.cart.length,
                            itemBuilder: (context, index) {
                              return CartItem(index: index);
                            });
                      },
                    ),
                  ),
                  Consumer<CartProvider>(
                    builder: (BuildContext context, value, Widget? child) {
                      final ValueNotifier<int?> totalPrice =
                          ValueNotifier(null);
                      for (var element in value.cart) {
                        totalPrice.value = (element.productPrice!.value *
                                element.quantity!.value) +
                            (totalPrice.value ?? 0);
                      }
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0, 1.0), //(x,y)
                              blurRadius: 6.0,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            smallVerticalSpacing(),
                            ValueListenableBuilder<int?>(
                                valueListenable: totalPrice,
                                builder: (context, val, child) {
                                  return Column(
                                    children: [
                                      // ReusableWidget(
                                      //     title: 'Sub-Total',
                                      //     value: 'Rp. $val'),
                                      const SizedBox(
                                        height: 5.0,
                                      ),
                                      ReusableWidget(
                                        title: 'Total',
                                        value:

                                            // 'Rp. $val'
                                            'Rp. ${convertPrice(val.toString())}',
                                      ),
                                      const SizedBox(
                                        height: 5.0,
                                      ),
                                    ],
                                  );
                                }),
                            smallVerticalSpacing()
                          ],
                        ),
                      );
                    },
                  )
                ],
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
                  if (provider.cartItemUpdated.isEmpty) {
                    Navigator.pop(context);
                  } else {
                    showLoading();
                    for (var i = 0; i < provider.cartItemUpdated.length; i++) {
                      provider
                          .updateProductCart(
                              itemId: provider.cartItemUpdated[i].id!,
                              qty: provider.cartItemUpdated[i].quantity!
                                  .toString())
                          .listen((event) {
                        if (event is AddToCartSuccess) {
                          if (i == (provider.cartItemUpdated.length - 1)) {
                            dismissLoading();
                            Navigator.pushNamed(context, CheckoutPage.routeName)
                                .then((_) {
                              provider.countTotalCartItem();
                            });
                          }
                        }
                      });
                    }
                  }

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
                    'Checkout',
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

class ReusableWidget extends StatelessWidget {
  final String title, value;
  const ReusableWidget({Key? key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: FONT_GENERAL),
          ),
          Text(
            value.toString(),
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: FONT_MEDIUM),
          ),
        ],
      ),
    );
  }
}
