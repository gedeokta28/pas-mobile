import 'package:flutter/material.dart';
import 'package:pas_mobile/core/utility/helper.dart';
import 'package:pas_mobile/features/quick_order/presentation/providers/quick_product_state.dart';
import 'package:provider/provider.dart';

import '../../../core/presentation/pages/main_page/main_page.dart';
import '../../../core/presentation/widgets/custom_app_bar.dart';
import '../../../core/presentation/widgets/custom_dialog_cart.dart';
import '../../../core/static/assets.dart';
import '../../../core/static/colors.dart';
import '../../../core/utility/injection.dart';
import '../../cart/presentation/cart_page.dart';
import '../../cart/presentation/providers/cart_provider.dart';
import 'providers/quick_order_provider.dart';
import 'providers/quick_order_state.dart';
import 'quick_order_list_page.dart';
import 'widget/rounded_button_quick_order.dart';

class QuickOrderPage extends StatefulWidget {
  const QuickOrderPage({
    Key? key,
  }) : super(key: key);
  static const routeName = '/quick_order';

  @override
  State<QuickOrderPage> createState() => _QuickOrderPageState();
}

class _QuickOrderPageState extends State<QuickOrderPage> {
  final _provider = locator<QuickOrderProvider>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => _provider,
        builder: (context, child) {
          _provider.fetchProduct();
          return Scaffold(
            backgroundColor: Colors.grey[200],
            appBar: const CustomAppBar(
              title: "Quick Order",
              centerTitle: true,
              canBack: false,
              hideShadow: false,
            ),
            body: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Consumer<QuickOrderProvider>(
                    builder: (BuildContext context, provider, widget) {
                  final state = provider.state;
                  if (state is QuickProductFailure) {
                    final failure = state.failure;
                    return Center(
                      child: Text(failure.message),
                    );
                  } else if (state is QuickProductLoaded) {
                    return const QuickOrderList();
                  }
                  return Center(
                    child: Image.asset(
                      ASSETS_LOADING,
                      height: 100.0,
                      width: 100.0,
                    ),
                  );
                })),
            bottomNavigationBar: Container(
                decoration: const BoxDecoration(
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black54,
                      offset: Offset(10.0, 10.0),
                      blurRadius: 15.0,
                    )
                  ],
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Consumer<QuickOrderProvider>(
                      builder: (context, provider, _) {
                    return RoundedButtonQuickOrder(
                      title: "Masukkan Keranjang ",
                      color: secondaryColor,
                      event: () {
                        provider.addToCart().listen((event) {
                          if (event is AddToCartQuickOrderLoading) {
                            showLoading();
                          } else if (event is AddToCartQuickOrderFailure) {
                            dismissLoading();
                          } else if (event is AddToCartQuickOrderSuccess) {
                            dismissLoading();
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) {
                                Future.delayed(
                                  const Duration(seconds: 1),
                                  () {
                                    Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      MainPage.routeName,
                                      (route) => false,
                                      arguments: 0, // navbar index
                                    );
                                    Navigator.pushNamed(
                                            context, CartPage.routeName)
                                        .then((_) {
                                      final provider =
                                          Provider.of<CartProvider>(
                                        locator<GlobalKey<NavigatorState>>()
                                            .currentContext!,
                                        listen: false,
                                      );
                                      provider.countTotalCartItem();
                                    });
                                  },
                                );
                                return const CustomDialogCart(
                                  text: 'Produk Dimasukkan Keranjang',
                                );
                              },
                            );
                          }
                        });
                      },
                    );
                  }),
                )),
          );
        });
  }
}
