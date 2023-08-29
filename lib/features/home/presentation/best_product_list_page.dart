import 'package:flutter/material.dart';
import 'package:pas_mobile/core/presentation/pages/main_page/main_page.dart';
import 'package:pas_mobile/features/cart/presentation/providers/cart_provider.dart';
import 'package:pas_mobile/features/filter/presentation/filter_page.dart';
import 'package:pas_mobile/features/home/presentation/product_page.dart';
import 'package:pas_mobile/features/home/presentation/providers/best_product_provider.dart';
import 'package:pas_mobile/features/home/presentation/widgets/card_product_item.dart';
import 'package:pas_mobile/features/home/presentation/widgets/home_app_bar.dart';
import 'package:pas_mobile/features/product/presentation/product_detail_page.dart';
import 'package:pas_mobile/features/quick_order/presentation/providers/quick_product_refresh_state.dart';
import 'package:pas_mobile/features/quick_order/presentation/providers/quick_product_state.dart';
import 'package:pas_mobile/features/search/data/models/filter_parameter.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../core/static/assets.dart';
import '../../../core/utility/injection.dart';

class BestProductListPage extends StatefulWidget {
  const BestProductListPage({
    Key? key,
  }) : super(key: key);
  static const routeName = '/best-product';

  @override
  State<BestProductListPage> createState() => _BestProductListPageState();
}

class _BestProductListPageState extends State<BestProductListPage> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final _provider = locator<BestProductProvider>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void _onLoading() async {
    if (_provider.nextUrl.isNotEmpty) {
      _provider.fetchNextData(_provider.nextUrl).listen((state) async {
        if (state is QuickProductRefreshLoading) {
          _refreshController.requestLoading();
        } else if (state is QuickProductRefreshLoaded) {
          await Future.delayed(const Duration(milliseconds: 1000));
          if (state.data.isNotEmpty) {
            _refreshController.loadComplete();
          } else {
            _refreshController.loadNoData();
          }
        } else if (state is QuickProductRefreshFailure) {
          _refreshController.loadFailed();
        }
      });
    } else {
      _refreshController.loadNoData();
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height) / 102;
    final double itemWidth = size.width / 61;
    return ChangeNotifierProvider(
        create: (_) => _provider,
        builder: (context, child) {
          _provider.fetchProduct();
          return Scaffold(
            appBar: const PreferredSize(
              preferredSize: Size(double.infinity, kToolbarHeight),
              child: HomeAppBar(
                isFromHome: false,
              ),
            ),
            body: SafeArea(
              child: Consumer<BestProductProvider>(
                  builder: (BuildContext context, provider, widget) {
                final state = provider.state;
                if (state is QuickProductFailure) {
                  final failure = state.failure;
                  return Center(
                    child: Text(failure.message),
                  );
                } else if (state is QuickProductLoaded) {
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
                                            const FilterPage(),
                                      ));
                                  FilterParameter filterParameter =
                                      FilterParameter(
                                          keyword: '',
                                          priceEnd: result.priceEnd,
                                          priceStart: result.priceStart,
                                          categoryId: result.categoryId);
                                  if (filterParameter.categoryId!.isEmpty &&
                                      filterParameter.priceStart! == 0 &&
                                      filterParameter.priceEnd! == 0) {
                                  } else {
                                    Navigator.pushReplacementNamed(
                                        context, MainPage.routeName);
                                    Navigator.pushNamed(
                                        context, ProductPage.routeName,
                                        arguments: ProductPageArguments(
                                            filterParameter: filterParameter));
                                  }
                                },
                                child: Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(
                                          width: 1.0, color: Colors.grey)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          "Filter",
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        const SizedBox(
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
                              SizedBox(
                                width: 150,
                                height: 40,
                                child: InputDecorator(
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4.0)),
                                    ),
                                    contentPadding: EdgeInsets.only(left: 8.0),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: 'terbaru',
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
                                        Navigator.pushReplacementNamed(
                                            context, MainPage.routeName);
                                        Navigator.pushNamed(
                                            context, ProductPage.routeName,
                                            arguments: ProductPageArguments(
                                                filterParameter:
                                                    FilterParameter(
                                                        priceBy: newValue!)));
                                      },
                                      style: const TextStyle(
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
                          child: SmartRefresher(
                            controller: _refreshController,
                            footer: CustomFooter(
                              builder:
                                  (BuildContext context, LoadStatus? mode) {
                                Widget body;
                                if (mode == LoadStatus.idle) {
                                  body = const Text("pull up load");
                                } else if (mode == LoadStatus.loading) {
                                  body = Image.asset(
                                    ASSETS_LOADING,
                                    height: 30.0,
                                    width: 100.0,
                                  );
                                } else if (mode == LoadStatus.failed) {
                                  body = const Text("Load Failed!Click retry!");
                                } else if (mode == LoadStatus.canLoading) {
                                  body = const Text("release to load more");
                                } else {
                                  body = const Text("No more Data");
                                }
                                return SizedBox(
                                  height: 55.0,
                                  child: Center(child: body),
                                );
                              },
                            ),
                            enablePullDown: false,
                            enablePullUp: true,
                            onLoading: _onLoading,
                            child: GridView.builder(
                                key: _scaffoldKey,
                                gridDelegate:
                                    SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 200,
                                  crossAxisSpacing: 8,
                                  childAspectRatio: (itemWidth / itemHeight),
                                ),
                                itemCount: provider.productList.length,
                                itemBuilder: (BuildContext ctx, index) {
                                  return GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(context,
                                                ProductDetailPage.routeName,
                                                arguments:
                                                    ProductDetailArguments(
                                                        productId: provider
                                                            .productList[index]
                                                            .stockid,
                                                        categoryId: provider
                                                            .productList[index]
                                                            .category
                                                            .categoryid))
                                            .then((_) {
                                          final provider =
                                              Provider.of<CartProvider>(
                                            context,
                                            listen: false,
                                          );
                                          provider.countTotalCartItem();
                                        });
                                      },
                                      child: CardProductItem(
                                          product:
                                              provider.productList[index]));
                                }),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return Center(
                  child: Image.asset(
                    ASSETS_LOADING,
                    height: 100.0,
                    width: 100.0,
                  ),
                );
              }),
            ),
          );
        });
  }
}
