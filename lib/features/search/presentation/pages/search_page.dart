import 'package:flutter/material.dart';
import 'package:pas_mobile/core/utility/helper.dart';
import 'package:pas_mobile/features/cart/presentation/cart_page.dart';
import 'package:pas_mobile/features/home/presentation/product_page.dart';
import 'package:provider/provider.dart';

import '../../../../core/presentation/widgets/search_app_bar.dart';
import '../../../../core/static/assets.dart';
import '../../../../core/utility/injection.dart';
import '../../../filter/presentation/filter_page.dart';
import '../../../home/presentation/providers/home_provider.dart';
import '../../../home/presentation/providers/product_state.dart';
import '../../../home/presentation/widgets/custom_card.dart';
import '../../../product/presentation/product_detail_page.dart';
import '../../../product/presentation/search_result_page.dart';
import '../providers/search_provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);
  static const routeName = '/search';

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final double itemHeight = (size.height) / 102;
    final double itemWidth = size.width / 60;
    return ChangeNotifierProvider(
      create: (_) => locator<SearchProvider>()..focus(),
      builder: (context, child) => Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size(double.infinity, kToolbarHeight),
          child: SearchAppBar(),
        ),
        body: SafeArea(
            child: Consumer<SearchProvider>(builder: (context, provider, _) {
          if (provider.isSearch) {
            if (provider.isLoadingSearch) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    ASSETS_LOADING,
                    height: 100.0,
                    width: 100.0,
                  ),
                ],
              );
            } else {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.separated(
                  separatorBuilder: (context, index) => Divider(
                    color: Colors.grey[400],
                  ),
                  itemCount: provider.listProductSearch.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                        onTap: () {
                          provider.setValueText(
                              provider.listProductSearch[index].stockname);
                        },
                        child:
                            Text(provider.listProductSearch[index].stockname)),
                  ),
                ),
              );
            }
          }
          // else if (provider.isSearchResult) {
          //   if (provider.isLoading) {
          //     return Center(
          //       child: Image.asset(
          //         ASSETS_LOADING,
          //         height: 100.0,
          //         width: 100.0,
          //       ),
          //     );
          //   } else {
          //     return Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: Column(
          //         children: [
          //           Padding(
          //             padding: const EdgeInsets.all(8.0),
          //             child: Row(
          //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //               children: [
          //                 GestureDetector(
          //                   onTap: () {
          //                     Navigator.pushNamed(
          //                         context, FilterPage.routeName);
          //                   },
          //                   child: Container(
          //                     height: 40,
          //                     decoration: BoxDecoration(
          //                         borderRadius: BorderRadius.circular(4),
          //                         border: Border.all(
          //                             width: 1.0, color: Colors.grey)),
          //                     child: Padding(
          //                       padding: EdgeInsets.symmetric(
          //                           horizontal: 10, vertical: 5),
          //                       child: Row(
          //                         mainAxisAlignment: MainAxisAlignment.center,
          //                         children: [
          //                           Text(
          //                             "Filter",
          //                             style: TextStyle(
          //                               fontSize: 13,
          //                               color: Colors.black87,
          //                             ),
          //                           ),
          //                           SizedBox(
          //                             width: 5,
          //                           ),
          //                           Image.asset(
          //                             ASSET_FILTER_ICON,
          //                             width: 20,
          //                             height: 20,
          //                             fit: BoxFit.cover,
          //                           ),
          //                         ],
          //                       ),
          //                     ),
          //                   ),
          //                 ),
          //                 Container(
          //                   width: 150,
          //                   height: 40,
          //                   child: InputDecorator(
          //                     decoration: InputDecoration(
          //                       border: OutlineInputBorder(
          //                         borderRadius: const BorderRadius.all(
          //                             Radius.circular(4.0)),
          //                       ),
          //                       contentPadding: EdgeInsets.only(left: 8.0),
          //                     ),
          //                     child: DropdownButtonHideUnderline(
          //                       child: DropdownButton<String>(
          //                         value: provider.selectedValue,
          //                         isDense: true,
          //                         icon: Image.asset(
          //                           ASSET_ICON_UPDOWN,
          //                           width: 25,
          //                           height: 25,
          //                           fit: BoxFit.cover,
          //                         ),
          //                         isExpanded: true,
          //                         items: provider.dropdownItems,
          //                         onChanged: (newValue) {
          //                           provider.setSelectedVal = newValue;
          //                         },
          //                         style: TextStyle(
          //                           fontSize: 13,
          //                           color: Colors.black87,
          //                         ),
          //                       ),
          //                     ),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //           Expanded(
          //             child: GridView.builder(
          //                 gridDelegate:
          //                     SliverGridDelegateWithMaxCrossAxisExtent(
          //                   maxCrossAxisExtent: 200,
          //                   childAspectRatio: (itemWidth / itemHeight),
          //                 ),
          //                 itemCount: provider.listProduct.length,
          //                 itemBuilder: (BuildContext ctx, index) {
          //                   return GestureDetector(
          //                       onTap: () {
          //                         provider.unfocus();
          //                         Navigator.pushNamed(
          //                             context, ProductDetailPage.routeName,
          //                             arguments: provider.listProduct[index]);
          //                       },
          //                       child: CustomCard(
          //                           product: provider.listProduct[index]));
          //                 }),
          //           ),
          //         ],
          //       ),
          //     );
          //   }
          // }
          return const SizedBox();
        })),
      ),
    );
  }
}
