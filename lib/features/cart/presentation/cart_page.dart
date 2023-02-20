import 'package:flutter/material.dart';
import 'package:pas_mobile/core/static/app_config.dart';
import 'package:pas_mobile/core/static/assets.dart';
import 'package:pas_mobile/core/static/colors.dart';
import 'package:pas_mobile/features/cart/presentation/cart_provider.dart';
import 'package:pas_mobile/features/cart/presentation/widgets/cart_item.dart';
import 'package:provider/provider.dart';

import '../../../../core/presentation/pages/main_page/main_page.dart';
import '../../../core/presentation/widgets/custom_app_bar.dart';
import '../../../core/presentation/widgets/rounded_button.dart';
import '../../../core/static/dimens.dart';
import '../../../core/utility/helper.dart';
import '../../../core/utility/injection.dart';

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
          appBar: CustomAppBar(
            title: "Keranjang",
            centerTitle: true,
            canBack: true,
            hideShadow: false,
          ),
          body: Consumer<CartProvider>(
              builder: (BuildContext context, provider, widget) {
            if (provider.cart.isEmpty) {
              return const Center(
                  child: Text(
                'Your Cart is Empty',
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
                      final cart = Provider.of<CartProvider>(context);

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
                    final ValueNotifier<int?> totalPrice = ValueNotifier(null);
                    for (var element in value.cart) {
                      totalPrice.value =
                          (element.productPrice! * element.quantity!.value) +
                              (totalPrice.value ?? 0);
                    }
                    return Column(
                      children: [
                        ValueListenableBuilder<int?>(
                            valueListenable: totalPrice,
                            builder: (context, val, child) {
                              return Column(
                                children: [
                                  ReusableWidget(
                                      title: 'Sub-Total', value: 'Rp. $val'),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  ReusableWidget(
                                      title: 'Total', value: 'Rp. $val'),
                                ],
                              );
                            }),
                        smallVerticalSpacing()
                      ],
                    );
                  },
                )
              ],
            );
          }),
          bottomNavigationBar: Consumer<CartProvider>(
              builder: (BuildContext context, provider, widget) {
            if (provider.cart.isEmpty) {
              return Container(
                height: 0,
              );
            } else {
              return InkWell(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Payment Successful'),
                      duration: Duration(seconds: 2),
                    ),
                  );
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
                fontWeight: FontWeight.bold, fontSize: FONT_GENERAL),
          ),
        ],
      ),
    );
  }
}
