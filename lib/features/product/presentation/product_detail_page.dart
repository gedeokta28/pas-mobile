import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pas_mobile/core/utility/global_function.dart';
import 'package:pas_mobile/features/cart/presentation/cart_page.dart';
import 'package:pas_mobile/features/cart/presentation/providers/add_cart_state.dart';
import 'package:pas_mobile/features/cart/presentation/providers/cart_provider.dart';
import 'package:pas_mobile/features/home/data/models/product_list_response_model.dart';
import 'package:pas_mobile/features/login/presentation/login_page.dart';
import 'package:pas_mobile/features/product/presentation/providers/app_bar_provider.dart';
import 'package:pas_mobile/features/product/presentation/providers/product_detail_state.dart';
import 'package:provider/provider.dart';

import '../../../core/presentation/widgets/custom_dialog_cart.dart';
import '../../../core/presentation/widgets/custom_simple_dialog.dart';
import '../../../core/presentation/widgets/rounded_button.dart';
import '../../../core/static/assets.dart';
import '../../../core/static/colors.dart';
import '../../../core/utility/helper.dart';
import '../../../core/utility/injection.dart';
import '../../cart/presentation/providers/cart_item_state.dart';
import 'providers/product_provider.dart';
import 'widgets/product_description.dart';
import 'widgets/product_detail_appbar.dart';

class ProductDetailArguments {
  final String productId;
  final String categoryId;

  ProductDetailArguments({required this.productId, required this.categoryId});
}

class ProductDetailPage extends StatefulWidget {
  final String productId;
  final String categoryId;
  const ProductDetailPage(
      {Key? key, required this.productId, required this.categoryId})
      : super(key: key);
  static const routeName = '/product-detail';

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final AppBarProvider _appBarProvider = locator<AppBarProvider>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext ctx) {
    // return ChangeNotifierProvider(
    //   create: (_) => locator<ProductProvider>()
    //     ..fetchProductDetail(widget.productId).listen((event) {})
    //     ..fetchRelatedProduct(widget.categoryId, widget.productId)
    //         .listen((event) {}),
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => locator<ProductProvider>()
            ..fetchProductDetail(widget.productId).listen((event) {})
            ..fetchRelatedProduct(widget.categoryId, widget.productId)
                .listen((event) {})
            ..fetchProductVariant(widget.productId).listen((event) {}),
        ),
        ChangeNotifierProvider(
          create: (_) => _appBarProvider
            ..fetchProductDetail(widget.productId).listen((event) {}),
        ),
      ],
      builder: (context, child) => WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: Scaffold(
            backgroundColor: Colors.white,
            body: Consumer<ProductProvider>(builder: (context, provider, _) {
              if (provider.isLoadingProduct) {
                return Center(
                  child: Image.asset(
                    ASSETS_LOADING,
                    height: 100.0,
                    width: 100.0,
                  ),
                );
              } else {
                return CustomScrollView(
                  slivers: [
                    ProductAppBar(productId: widget.productId),
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          mediumVerticalSpacing(),
                          const ProductDescription(),
                          smallVerticalSpacing(),
                        ],
                      ),
                    ),
                  ],
                );
              }
            }),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Material(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Consumer<CartProvider>(
                  builder: (context, provider, _) => RoundedButton(
                    title: "Masukkan Keranjang",
                    color: primaryColor,
                    event: () async {
                      final _providerProduct = Provider.of<ProductProvider>(
                        context,
                        listen: false,
                      );
                      showLoading();
                      checkUserSession().then((value) {
                        if (value) {
                          FormData formData = FormData.fromMap({
                            'stockid': _providerProduct.productId,
                            'qty': 1,
                          });
                          provider.addProductToCart(formData).listen((event) {
                            if (event is AddToCartSuccess) {
                              provider.fetchCart().listen((event) {
                                if (event is CartItemSuccess) {
                                  dismissLoading();

                                  _appBarProvider.setTotalCartItem =
                                      event.data.length;
                                  showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) {
                                      Future.delayed(
                                        const Duration(seconds: 1),
                                        () {
                                          Navigator.of(context).pop(true);
                                        },
                                      );
                                      return const CustomDialogCart(
                                        text: 'Produk Dimasukkan Keranjang',
                                      );
                                    },
                                  );
                                }
                              });

                              // Navigator.pushNamed(context, CartPage.routeName);
                            } else if (event is AddToCartFailure) {
                              dismissLoading();
                              final msg = getErrorMessage(event.failure);
                              showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context) {
                                    return CustomSimpleDialog(
                                        text: msg,
                                        onTap: () {
                                          Navigator.pop(context);
                                        });
                                  });
                            }
                          });
                        } else {
                          Navigator.pushNamed(context, LoginPage.routeName);
                        }
                      });
                    },
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
