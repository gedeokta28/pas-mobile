import 'package:flutter/material.dart';

import 'package:pas_mobile/features/product/presentation/providers/search_result_provider.dart';
import 'package:provider/provider.dart';
import '../../../core/utility/injection.dart';
import '../../home/presentation/widgets/home_app_bar.dart';

class SearchResultPage extends StatefulWidget {
  const SearchResultPage({Key? key}) : super(key: key);
  static const routeName = '/search-result';

  @override
  State<SearchResultPage> createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => locator<SearchResultProvider>(),
      builder: (context, child) => Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size(double.infinity, kToolbarHeight),
          child: HomeAppBar(
            isFromHome: false,
          ),
        ),
        body: Consumer<SearchResultProvider>(builder: (context, provider, _) {
          provider.fetchCategoryList().listen((event) {});
          return const Center(
            child: Text("Adas"),
          );
        }),
        // body: Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child:
        //         Consumer<SearchResultProvider>(builder: (context, provider, _) {
        //       return StreamBuilder<ProductState>(
        //           stream:
        //               context.read<SearchResultProvider>().fetchProductList(),
        //           builder: (_, snap) {
        //             if (snap.hasData) {
        //               if (snap.data is ProductLoaded) {
        //                 final _product = (snap.data as ProductLoaded).data;
        //                 return Column(
        //                   children: [
        //                     Padding(
        //                       padding: const EdgeInsets.all(8.0),
        //                       child: Row(
        //                         mainAxisAlignment:
        //                             MainAxisAlignment.spaceBetween,
        //                         children: [
        //                           GestureDetector(
        //                             onTap: () {
        //                               Navigator.pushNamed(
        //                                   context, FilterPage.routeName);
        //                             },
        //                             child: Container(
        //                               height: 40,
        //                               decoration: BoxDecoration(
        //                                   borderRadius:
        //                                       BorderRadius.circular(4),
        //                                   border: Border.all(
        //                                       width: 1.0, color: Colors.grey)),
        //                               child: Padding(
        //                                 padding: EdgeInsets.symmetric(
        //                                     horizontal: 10, vertical: 5),
        //                                 child: Row(
        //                                   mainAxisAlignment:
        //                                       MainAxisAlignment.center,
        //                                   children: [
        //                                     Text(
        //                                       "Filter",
        //                                       style: TextStyle(
        //                                         fontSize: 13,
        //                                         color: Colors.black87,
        //                                       ),
        //                                     ),
        //                                     SizedBox(
        //                                       width: 5,
        //                                     ),
        //                                     Image.asset(
        //                                       ASSET_FILTER_ICON,
        //                                       width: 20,
        //                                       height: 20,
        //                                       fit: BoxFit.cover,
        //                                     ),
        //                                   ],
        //                                 ),
        //                               ),
        //                             ),
        //                           ),
        //                           Container(
        //                             width: 150,
        //                             height: 40,
        //                             child: InputDecorator(
        //                               decoration: InputDecoration(
        //                                 border: OutlineInputBorder(
        //                                   borderRadius: const BorderRadius.all(
        //                                       Radius.circular(4.0)),
        //                                 ),
        //                                 contentPadding:
        //                                     EdgeInsets.only(left: 8.0),
        //                               ),
        //                               child: DropdownButtonHideUnderline(
        //                                 child: DropdownButton<String>(
        //                                   value: provider.selectedValue,
        //                                   isDense: true,
        //                                   icon: Image.asset(
        //                                     ASSET_ICON_UPDOWN,
        //                                     width: 25,
        //                                     height: 25,
        //                                     fit: BoxFit.cover,
        //                                   ),
        //                                   isExpanded: true,
        //                                   items: provider.dropdownItems,
        //                                   onChanged: (newValue) {
        //                                     provider.setSelectedVal = newValue;
        //                                   },
        //                                   style: TextStyle(
        //                                     fontSize: 13,
        //                                     color: Colors.black87,
        //                                   ),
        //                                 ),
        //                               ),
        //                             ),
        //                           ),
        //                           // Padding(
        //                           //   padding: EdgeInsets.all(5.0),
        //                           //   child: DropdownButton<String>(
        //                           //       value: provider.selectedValue,
        //                           //       icon: Icon(Icons.flag),
        //                           //       onChanged: (String? newValue) {},

        //                           //       items: provider.dropdownItems),
        //                           // ),
        //                         ],
        //                       ),
        //                     ),
        //                     Expanded(
        //                       child: GridView.builder(
        //                           gridDelegate:
        //                               SliverGridDelegateWithMaxCrossAxisExtent(
        //                             maxCrossAxisExtent: 200,
        //                             childAspectRatio: (itemWidth / itemHeight),
        //                           ),
        //                           itemCount: _product.length,
        //                           itemBuilder: (BuildContext ctx, index) {
        //                             return GestureDetector(
        //                                 onTap: () {
        //                                   Navigator.pushNamed(context,
        //                                       ProductDetailPage.routeName,
        //                                       arguments: _product[index]);
        //                                 },
        //                                 child: CustomCard(
        //                                     product: _product[index]));
        //                           }),
        //                     ),
        //                   ],
        //                 );
        //               } else if (snap.data is ProductLoading) {
        //                 return Center(
        //                   child: Image.asset(
        //                     ASSETS_LOADING,
        //                     height: 100.0,
        //                     width: 100.0,
        //                   ),
        //                 );
        //               }
        //             }
        //             return const SizedBox.shrink();
        //           });
        //     })),
      ),
    );
  }
}
