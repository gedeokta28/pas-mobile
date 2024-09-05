import 'package:flutter/material.dart';
import 'package:pas_mobile/features/home/presentation/providers/home_provider.dart';
import 'package:pas_mobile/features/home/presentation/providers/product_state.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/static/app_config.dart';
import '../../../cart/presentation/providers/cart_provider.dart';
import '../product_page.dart';
import 'card_widget.dart';
import 'category_selection_title.dart';

class NewsProductList extends StatelessWidget {
  const NewsProductList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTitleWidget(
          onTap: () {
            Navigator.pushNamed(context, ProductPage.routeName).then((_) {
              final provider = Provider.of<CartProvider>(
                context,
                listen: false,
              );
              provider.countTotalCartItem();
            });
          },
          title: 'Produk Terbaru',
        ),
        SizedBox(
          height: 8.0,
        ),
        StreamBuilder<ProductState>(
            stream: context.read<HomeProvider>().fetchProductList(null),
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
                        scrollDirection: Axis.horizontal,
                        itemCount: _product.length > 6 ? 5 : _product.length,
                        itemBuilder: (BuildContext context, int index) {
                          return CardWidget(
                            product: _product[index],
                          );
                        }),
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
      ],
    );
  }
}
