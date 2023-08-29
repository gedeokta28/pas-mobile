import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:pas_mobile/core/presentation/widgets/custom_simple_dialog.dart';
import 'package:pas_mobile/core/utility/helper.dart';
import 'package:pas_mobile/features/quick_order/presentation/providers/quick_product_filter.dart';
import 'package:pas_mobile/features/quick_order/presentation/providers/quick_product_state.dart';
import 'package:provider/provider.dart';

import '../../../core/presentation/pages/main_page/main_page.dart';
import '../../../core/presentation/widgets/custom_app_bar.dart';
import '../../../core/presentation/widgets/custom_dialog_cart.dart';
import '../../../core/presentation/widgets/custom_search_bar.dart';
import '../../../core/static/assets.dart';
import '../../../core/static/colors.dart';
import '../../../core/static/dimens.dart';
import '../../../core/utility/injection.dart';
import '../../cart/presentation/cart_page.dart';
import '../../cart/presentation/providers/cart_provider.dart';
import 'providers/quick_order_provider.dart';
import 'providers/quick_order_state.dart';
import 'quick_order_list_page.dart';
import 'quick_order_search_page.dart';
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
            appBar: CustomAppBar(
              wTitle: Consumer<QuickOrderProvider>(
                  builder: (BuildContext context, provider, widget) {
                return CustomSearchBar(
                  hint: "Search",
                  controller: provider.controller,
                  height: kToolbarHeight - SIZE_MEDIUM,
                  onSubmitted: (value) {
                    provider.setIsSearch = true;
                    provider.filterProduct(value);
                  },
                  onClear: () {
                    if (provider.controller.text.isNotEmpty) {
                      provider.controller.clear();
                      provider.setIsSearch = false;
                      provider.fetchProduct();
                    }
                  },
                  onChanged: (value) {
                    if (value.isEmpty) {
                      provider.setIsSearch = false;
                      provider.fetchProduct();
                    }
                  },
                  focusNode: FocusNode(),
                );
              }),
              centerTitle: true,
              canBack: false,
              hideShadow: false,
              actions: [
                sessionHelper.isLoggedIn
                    ? AspectRatio(
                        aspectRatio: 1 / 1,
                        child: Stack(
                          children: [
                            Consumer<CartProvider>(
                                builder: (context, provider, _) =>
                                    LayoutBuilder(builder: (_, constraints) {
                                      return Center(
                                        child: ClipRRect(
                                          child: Material(
                                            color: Colors.transparent,
                                            child: InkWell(
                                              child: Padding(
                                                padding: sessionHelper
                                                        .isLoggedIn
                                                    ? const EdgeInsets.all(5)
                                                    : const EdgeInsets.only(
                                                        left: 15.0,
                                                        top: 5,
                                                        right: 5,
                                                        bottom: 5),
                                                child: const Icon(
                                                  Icons.shopping_cart,
                                                  size: 30.0,
                                                  color: secondaryColor,
                                                ),
                                              ),
                                              onTap: () {
                                                Navigator.pushNamed(context,
                                                        CartPage.routeName)
                                                    .then((_) {
                                                  provider.countTotalCartItem();
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                      );
                                    })),
                            Consumer<CartProvider>(
                              builder: (context, provider, _) =>
                                  LayoutBuilder(builder: (_, constraints) {
                                if (provider.isLoadCart) {
                                  return const SizedBox.shrink();
                                } else {
                                  final size = (constraints.maxWidth / 2) - 8.0;
                                  if (provider.totalCartItem == 0) {
                                    return const SizedBox.shrink();
                                  }
                                  return InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                              context, CartPage.routeName)
                                          .then((_) {
                                        provider.countTotalCartItem();
                                      });
                                    },
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: Container(
                                          margin: const EdgeInsets.all(7.0),
                                          padding: const EdgeInsets.all(2.0),
                                          width: size,
                                          height: size,
                                          alignment: Alignment.center,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: secondaryColor,
                                          ),
                                          child: AutoSizeText(
                                            provider.totalCartItem.toString(),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            minFontSize: 8.0,
                                          )),
                                    ),
                                  );
                                }
                              }),
                            )
                          ],
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
            body: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Consumer<QuickOrderProvider>(
                    builder: (BuildContext context, provider, widget) {
                  if (!provider.isSearch) {
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
                  } else {
                    final state = provider.stateSearch;
                    if (state is QuickProductFilterFailure) {
                      final failure = state.failure;
                      return Center(
                        child: Text(failure.message),
                      );
                    } else if (state is QuickProductFilterLoaded) {
                      return const QuickOrderListSearch();
                    }
                    return Center(
                      child: Image.asset(
                        ASSETS_LOADING,
                        height: 100.0,
                        width: 100.0,
                      ),
                    );
                  }
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
                        if (provider.selectedProduct.isEmpty) {
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) {
                                return CustomSimpleDialog(
                                    text: 'Harap pilih product !',
                                    onTap: () {
                                      Navigator.pop(context);
                                    });
                              });
                        } else {
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
                                      final provider =
                                          Provider.of<CartProvider>(
                                        locator<GlobalKey<NavigatorState>>()
                                            .currentContext!,
                                        listen: false,
                                      );
                                      provider.countTotalCartItem();
                                      Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        MainPage.routeName,
                                        (route) => false,
                                        arguments: 2, // navbar index
                                      );
                                      // Navigator.pushNamed(
                                      //         context, CartPage.routeName)
                                      //     .then((_) {
                                      //   final provider =
                                      //       Provider.of<CartProvider>(
                                      //     locator<GlobalKey<NavigatorState>>()
                                      //         .currentContext!,
                                      //     listen: false,
                                      //   );
                                      //   provider.countTotalCartItem();
                                      // });
                                    },
                                  );
                                  return const CustomDialogCart(
                                    text: 'Produk Dimasukkan Keranjang',
                                  );
                                },
                              );
                            }
                          });
                        }
                      },
                    );
                  }),
                )),
          );
        });
  }
}
