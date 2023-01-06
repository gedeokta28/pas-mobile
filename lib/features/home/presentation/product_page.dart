import 'package:flutter/material.dart';
import 'package:pas_mobile/features/home/presentation/providers/home_provider.dart';
import 'package:pas_mobile/features/product/presentation/product_detail_filter_page.dart';
import 'package:pas_mobile/features/search/data/models/filter_parameter.dart';
import 'package:provider/provider.dart';

import '../../../../core/static/assets.dart';
import '../../../../core/utility/injection.dart';
import '../../filter/presentation/filter_page.dart';
import '../../product/presentation/product_detail_page.dart';
import 'widgets/custom_card_filter.dart';
import 'widgets/home_app_bar.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);
  static const routeName = '/product';

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height) / 102;
    final double itemWidth = size.width / 60;
    return ChangeNotifierProvider(
      create: (_) => locator<HomeProvider>()
        ..filterCustomProduct(FilterParameter(
                keyword: '', priceEnd: 0, priceStart: 0, categoryId: ''))
            .listen((event) {}),
      builder: (context, child) => Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, kToolbarHeight),
          child: HomeAppBar(
            isFromHome: false,
          ),
        ),
        body: SafeArea(
            child: Consumer<HomeProvider>(builder: (context, provider, _) {
          if (provider.isLoadingProduct) {
            return Center(
              child: Image.asset(
                ASSETS_LOADING,
                height: 100.0,
                width: 100.0,
              ),
            );
          } else {
            if (provider.listProductFilter.isEmpty) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              FilterParameter result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        FilterPage(),
                                  ));
                              FilterParameter filterParameter = FilterParameter(
                                  keyword: '',
                                  priceEnd: result.priceEnd,
                                  priceStart: result.priceStart,
                                  categoryId: result.categoryId);
                              provider
                                  .filterCustomProduct(filterParameter)
                                  .listen((event) {});
                            },
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                      width: 1.0, color: Colors.grey)),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Filter",
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Image.asset(
                                      ASSET_FILTER_ICON,
                                      width: 20,
                                      height: 20,
                                      fit: BoxFit.cover,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 150,
                            height: 40,
                            child: InputDecorator(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(4.0)),
                                ),
                                contentPadding: EdgeInsets.only(left: 8.0),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: provider.selectedValue,
                                  isDense: true,
                                  icon: Image.asset(
                                    ASSET_ICON_UPDOWN,
                                    width: 25,
                                    height: 25,
                                    fit: BoxFit.cover,
                                  ),
                                  isExpanded: true,
                                  items: provider.dropdownItems,
                                  onChanged: (newValue) {
                                    provider.setSelectedVal = newValue;
                                  },
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    Center(
                      child: Text(
                        "Product Tidak Tersedia",
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              FilterParameter result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        FilterPage(),
                                  ));
                              FilterParameter filterParameter = FilterParameter(
                                  keyword: '',
                                  priceEnd: result.priceEnd,
                                  priceStart: result.priceStart,
                                  categoryId: result.categoryId);
                              provider
                                  .filterCustomProduct(filterParameter)
                                  .listen((event) {});
                            },
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                      width: 1.0, color: Colors.grey)),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Filter",
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Image.asset(
                                      ASSET_FILTER_ICON,
                                      width: 20,
                                      height: 20,
                                      fit: BoxFit.cover,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 150,
                            height: 40,
                            child: InputDecorator(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(4.0)),
                                ),
                                contentPadding: EdgeInsets.only(left: 8.0),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: provider.selectedValue,
                                  isDense: true,
                                  icon: Image.asset(
                                    ASSET_ICON_UPDOWN,
                                    width: 25,
                                    height: 25,
                                    fit: BoxFit.cover,
                                  ),
                                  isExpanded: true,
                                  items: provider.dropdownItems,
                                  onChanged: (newValue) {
                                    provider.setSelectedVal = newValue;
                                  },
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.black87,
                                  ),
                                ),
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
                          itemCount: provider.listProductFilter.length,
                          itemBuilder: (BuildContext ctx, index) {
                            return GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, ProductDetailPage.routeName,
                                      arguments: ProductDetailArguments(
                                          productId: provider
                                              .listProductFilter[index].stockid,
                                          categoryId: provider
                                              .listProductFilter[index]
                                              .category
                                              .categoryid));
                                },
                                child: CustomCardFilter(
                                    product:
                                        provider.listProductFilter[index]));
                          }),
                    ),
                  ],
                ),
              );
            }
          }
        })),
      ),
    );
  }
}
