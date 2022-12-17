import 'package:flutter/material.dart';
import 'package:pas_mobile/core/utility/helper.dart';
import 'package:pas_mobile/features/home/presentation/providers/home_provider.dart';
import 'package:pas_mobile/features/home/presentation/providers/product_state.dart';
import 'package:pas_mobile/features/home/presentation/widgets/banner_slider.dart';
import 'package:pas_mobile/features/home/presentation/widgets/best_product.dart';
import 'package:pas_mobile/features/home/presentation/widgets/card_widget.dart';
import 'package:pas_mobile/features/home/presentation/widgets/category_selection.dart';
import 'package:pas_mobile/features/home/presentation/widgets/custom_card.dart';
import 'package:pas_mobile/features/home/presentation/widgets/news_product.dart';
import 'package:provider/provider.dart';

import '../../../core/static/assets.dart';
import '../../../core/static/colors.dart';
import '../../../core/utility/injection.dart';
import '../../product/presentation/product_detail_page.dart';
import 'widgets/home_app_bar.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({Key? key}) : super(key: key);
  static const routeName = '/product';

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height) / 103;
    final double itemWidth = size.width / 60;
    return ChangeNotifierProvider(
      create: (_) => locator<HomeProvider>(),
      builder: (context, child) => Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size(double.infinity, kToolbarHeight),
          child: HomeAppBar(
            isFromHome: false,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          // implement GridView.builder
          child: StreamBuilder<ProductState>(
              stream: context.read<HomeProvider>().fetchProductList(),
              builder: (_, snap) {
                if (snap.hasData) {
                  if (snap.data is ProductLoaded) {
                    final _product = (snap.data as ProductLoaded).data;
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        width: 1.0, color: primaryColor)),
                                child: Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Text("Filter"),
                                      Icon(
                                        Icons.filter_alt,
                                        color: primaryColor,
                                        size: 20.0,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 200,
                                childAspectRatio: (itemWidth / itemHeight),
                              ),
                              itemCount: _product.length,
                              itemBuilder: (BuildContext ctx, index) {
                                return GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, ProductDetailPage.routeName,
                                          arguments: _product[index]);
                                    },
                                    child:
                                        CustomCard(product: _product[index]));
                              }),
                        ),
                      ],
                    );
                  } else if (snap.data is ProductLoading) {
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
        ),
      ),
    );
  }
}
