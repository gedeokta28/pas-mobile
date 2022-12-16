import 'package:flutter/material.dart';
import 'package:pas_mobile/core/static/assets.dart';
import 'package:pas_mobile/core/utility/helper.dart';
import 'package:pas_mobile/features/home/presentation/providers/home_provider.dart';
import 'package:pas_mobile/features/home/presentation/providers/product_state.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/presentation/widgets/shimmer_card.dart';
import '../../../../core/static/app_config.dart';
import 'card_widget.dart';
import 'category_selection_title.dart';

class NewsProductList extends StatelessWidget {
  const NewsProductList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CategorySelectionTitle(
          onTap: () {},
          title: 'Product Terbaru',
        ),
        StreamBuilder<ProductState>(
            stream: context.read<HomeProvider>().fetchProductList(),
            builder: (_, snap) {
              if (snap.hasData) {
                if (snap.data is ProductLoaded) {
                  final _product = (snap.data as ProductLoaded).data;
                  return SizedBox(
                    height: 210.0,
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
                  return Center(
                    child: Image.asset(
                      ASSETS_LOADING,
                      height: 100.0,
                      width: 100.0,
                    ),
                  );
                }
              }
              return const SizedBox.shrink();
            }),
      ],
    );
  }
}
