import 'package:flutter/material.dart';
import 'package:pas_mobile/core/static/assets.dart';
import 'package:pas_mobile/core/utility/enum.dart';
import 'package:pas_mobile/features/brand/presentation/providers/brand_state.dart';
import 'package:pas_mobile/features/brand/presentation/widgets/brand_item.dart';
import 'package:pas_mobile/features/category/presentation/widgets/category_item.dart';
import 'package:provider/provider.dart';

import '../../../core/presentation/widgets/custom_app_bar.dart';
import '../../../core/static/dimens.dart';
import '../../../core/utility/injection.dart';
import '../../home/presentation/product_page.dart';
import 'providers/brand_provider.dart';

class BrandPage extends StatelessWidget {
  const BrandPage({
    Key? key,
  }) : super(key: key);
  static const routeName = '/brand';

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height) / 102;
    final double itemWidth = size.width / 60;
    return ChangeNotifierProvider(
      create: (_) => locator<BrandProvider>(),
      builder: (context, child) => Scaffold(
        appBar: const CustomAppBar(
          title: "Brand",
          centerTitle: true,
          canBack: false,
          hideShadow: false,
        ),
        body: SafeArea(
          child: StreamBuilder<BrandState>(
              stream: context.read<BrandProvider>().fetchBrandList(),
              builder: (_, snap) {
                if (snap.hasData) {
                  if (snap.data is BrandLoaded) {
                    final _brand = (snap.data as BrandLoaded).data;
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Expanded(
                            child: GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent: 150,
                                        childAspectRatio:
                                            (itemWidth / itemHeight),
                                        crossAxisSpacing: 10),
                                itemCount: _brand.length,
                                itemBuilder: (BuildContext ctx, index) {
                                  return GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, ProductPage.routeName,
                                            arguments: ProductPageArguments(
                                              productPageParams:
                                                  ProductPageParams.fromBrand,
                                              brandName:
                                                  _brand[index].brandname,
                                              brandId: _brand[index].brandid,
                                            ));
                                      },
                                      child: BrandItem(brand: _brand[index]));
                                }),
                          ),
                        ],
                      ),
                    );
                  } else if (snap.data is BrandLoading) {
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
