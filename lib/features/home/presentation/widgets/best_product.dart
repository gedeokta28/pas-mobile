import 'package:flutter/material.dart';
import 'package:pas_mobile/features/home/presentation/best_product_list_page.dart';
import 'package:pas_mobile/features/home/presentation/product_page.dart';
import 'package:pas_mobile/features/search/data/models/filter_parameter.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/static/app_config.dart';
import '../../../cart/presentation/providers/cart_provider.dart';
import '../providers/home_provider.dart';
import '../providers/product_state.dart';
import 'card_widget.dart';
import 'package:provider/provider.dart';
import 'category_selection_title.dart';

class BestProductList extends StatelessWidget {
  const BestProductList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTitleWidget(
          onTap: () {
            FilterParameter _filterParameter;
            _filterParameter = FilterParameter(
              keyword: '',
              sortBy: "best-seller-asc",
            );
            Navigator.pushNamed(context, ProductPage.routeName,
                    arguments:
                        ProductPageArguments(filterParameter: _filterParameter))
                .then((_) {
              final provider = Provider.of<CartProvider>(
                context,
                listen: false,
              );
              provider.countTotalCartItem();
            });
            // Navigator.pushNamed(context, BestProductListPage.routeName)
            //     .then((_) {
            //   final provider = Provider.of<CartProvider>(
            //     context,
            //     listen: false,
            //   );
            //   provider.countTotalCartItem();
            // });
          },
          title: 'Produk Terlaris',
        ),
        SizedBox(
          height: 8.0,
        ),
        StreamBuilder<ProductState>(
            stream:
                context.read<HomeProvider>().fetchProductList('best-product'),
            builder: (_, snap) {
              if (snap.hasData) {
                if (snap.data is ProductLoaded) {
                  final _product = (snap.data as ProductLoaded).data;
                  return Container(
                    height: 225,
                    padding: const EdgeInsets.only(left: 12.0),
                    child: ListView.builder(
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _product.length > 6 ? 5 : _product.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return CardWidget(product: _product[index]);
                      },
                    ),
                  );
                } else if (snap.data is ProductLoading) {
                  return SizedBox(
                      height: 160.0,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0, top: 10.0),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return Shimmer.fromColors(
                              direction: ShimmerDirection.ltr,
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Container(
                                  width: App(context).appWidth(35),
                                  color: Colors.grey.shade300,
                                  margin: const EdgeInsets.only(bottom: 10),
                                ),
                              ),
                            );
                          },
                        ),
                      ));
                }
              }
              return SizedBox(
                  height: 160.0,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0, top: 10.0),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                          direction: ShimmerDirection.ltr,
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Container(
                              width: App(context).appWidth(35),
                              color: Colors.grey.shade300,
                              margin: const EdgeInsets.only(bottom: 10),
                            ),
                          ),
                        );
                      },
                    ),
                  ));
            }),
        SizedBox(
          height: 5.0,
        ),
      ],
    );
  }
}
