import 'package:flutter/material.dart';
import 'package:pas_mobile/core/utility/global_function.dart';
import 'package:pas_mobile/features/cart/presentation/cart_page.dart';
import 'package:pas_mobile/features/home/data/models/product_list_response_model.dart';
import 'package:pas_mobile/features/login/presentation/login_page.dart';
import 'package:provider/provider.dart';

import '../../../core/presentation/widgets/rounded_button.dart';
import '../../../core/static/colors.dart';
import '../../../core/utility/helper.dart';
import '../../../core/utility/injection.dart';
import 'providers/product_provider.dart';
import 'widgets/product_description.dart';
import 'widgets/product_detail_appbar.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;
  const ProductDetailPage({Key? key, required this.product}) : super(key: key);
  static const routeName = '/product-detail';

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => locator<ProductProvider>(),
      builder: (context, child) => WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: Scaffold(
            backgroundColor: Colors.white,
            body: CustomScrollView(
              slivers: [
                ProductAppBar(
                  imageUrl: widget.product.photourl!,
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      ProductDescription(product: widget.product),
                      smallVerticalSpacing(),
                    ],
                  ),
                ),
              ],
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Material(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: RoundedButton(
                  title: "Masukkan Keranjang",
                  color: primaryColor,
                  event: () {
                    checkUserSession().then((value) {
                      if (value) {
                        Navigator.pushNamed(context, CartPage.routeName);
                      } else {
                        Navigator.pushNamed(context, LoginPage.routeName);
                      }
                    });
                  },
                ),
              ),
            )),
      ),
    );
  }
}
