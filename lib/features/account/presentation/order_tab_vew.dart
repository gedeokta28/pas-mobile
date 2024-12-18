import 'package:flutter/material.dart';
import 'package:pas_mobile/core/utility/helper.dart';

import 'package:pas_mobile/features/account/presentation/widgets/order_item_card.dart';
import 'package:pas_mobile/features/order/presentation/providers/order_provider.dart';
import 'package:provider/provider.dart';

import '../../../core/static/assets.dart';
import '../../../core/utility/injection.dart';
import '../../order/presentation/order_detail_page.dart';

class OrderProfileTab extends StatefulWidget {
  const OrderProfileTab({Key? key, required this.parentController})
      : super(key: key);

  final ScrollController parentController;

  @override
  OrderProfileTabState createState() => OrderProfileTabState();
}

class OrderProfileTabState extends State<OrderProfileTab>
    with AutomaticKeepAliveClientMixin<OrderProfileTab> {
  @override
  bool get wantKeepAlive => true;
  late ScrollController _scrollController;

  late ScrollPhysics ph;
  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();

    _scrollController.addListener(() {
      var innerPos = _scrollController.position.pixels;
      var maxOuterPos = widget.parentController.position.maxScrollExtent;
      var currentOutPos = widget.parentController.position.pixels;

      if (innerPos >= 0 && currentOutPos < maxOuterPos) {
        widget.parentController.position.jumpTo(innerPos + currentOutPos);
      } else {
        var currenParentPos = innerPos + currentOutPos;
        widget.parentController.position.jumpTo(currenParentPos);
      }
    });

    widget.parentController.addListener(() {
      var currentOutPos = widget.parentController.position.pixels;
      if (currentOutPos <= 0) {
        _scrollController.position.jumpTo(0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
        create: (context) =>
            locator<OrderProvider>()..fetchListOrder().listen((event) {}),
        child: Consumer<OrderProvider>(builder: (context, provider, _) {
          if (provider.isLoadOrder) {
            return Center(
              child: Image.asset(
                ASSETS_LOADING,
                height: 100.0,
                width: 100.0,
              ),
            );
          } else {
            return Column(
              children: [
                // Input pencarian untuk DeliveryTo
                TextField(
                  onChanged: (value) {
                    provider.updateSearch(value, provider.searchSalesOrderDate);
                  },
                  decoration: InputDecoration(
                    labelText: 'Cari Nama Pengiriman',
                  ),
                ),

// DatePicker untuk salesorderdate
                TextButton(
                  onPressed: () async {
                    final selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    provider.updateSearch(
                        provider.searchDeliveryTo, selectedDate);
                  },
                  child: Text(provider.searchSalesOrderDate != null
                      ? 'Tanggal Dipilih: ${convertDate(provider.searchSalesOrderDate!)}'
                      : 'Pilih Tanggal Pesanan'),
                ),

                // Kondisi jika tidak ada hasil pencarian
                Expanded(
                  child: provider.listOrder.isEmpty
                      ? Center(
                          child: Text(
                            'No data found',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        )
                      : SingleChildScrollView(
                          controller: _scrollController,
                          child: RefreshIndicator(
                            onRefresh: provider.refreshData,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 50),
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        OrderDetailPage.routeName,
                                        arguments: OrderDetailPageArguments(
                                          orderId: provider
                                              .listOrder[index].salesorderno,
                                          isFromCheckout: false,
                                        ),
                                      );
                                    },
                                    child: OrderItemCard(
                                      orderData: provider.listOrder[index],
                                    ),
                                  );
                                },
                                itemCount: provider.listOrder.length,
                              ),
                            ),
                          ),
                        ),
                ),
              ],
            );
            // if (provider.listOrder.isEmpty) {
            //   return const Center(
            //       child: Text(
            //     'Belum Memiliki Pesanan',
            //     style: TextStyle(
            //         fontWeight: FontWeight.bold,
            //         fontSize: 15.0,
            //         color: Colors.grey),
            //   ));
            // } else {
            //   return Column(
            //     children: [
            //       TextField(
            //         onChanged: (value) {
            //           provider.updateSearch(
            //               value, provider.searchSalesOrderDate);
            //         },
            //         decoration: InputDecoration(
            //           labelText: 'Search by Delivery To',
            //         ),
            //       ),
            //       // DatePicker untuk salesorderdate
            //       TextButton(
            //         onPressed: () async {
            //           final selectedDate = await showDatePicker(
            //             context: context,
            //             initialDate: DateTime.now(),
            //             firstDate: DateTime(2000),
            //             lastDate: DateTime(2101),
            //           );
            //           provider.updateSearch(
            //               provider.searchDeliveryTo, selectedDate);
            //         },
            //         child: Text(provider.searchSalesOrderDate != null
            //             ? 'Selected Date: ${provider.searchSalesOrderDate}'
            //             : 'Pick a Sales Order Date'),
            //       ),
            //       Expanded(
            //         child: SingleChildScrollView(
            //           controller: _scrollController,
            //           child: RefreshIndicator(
            //             onRefresh: provider.refreshData,
            //             child: Padding(
            //               padding: const EdgeInsets.only(bottom: 50),
            //               child: ListView.builder(
            //                 padding: EdgeInsets.zero,
            //                 physics: const NeverScrollableScrollPhysics(),
            //                 shrinkWrap: true,
            //                 itemBuilder: (context, index) {
            //                   return InkWell(
            //                       onTap: () {
            //                         Navigator.pushNamed(
            //                             context, OrderDetailPage.routeName,
            //                             arguments: OrderDetailPageArguments(
            //                                 orderId: provider
            //                                     .listOrder[index].salesorderno,
            //                                 isFromCheckout: false));
            //                       },
            //                       child: OrderItemCard(
            //                           orderData: provider.listOrder[index]));
            //                 },
            //                 itemCount: provider.listOrder.length,
            //               ),
            //             ),
            //           ),
            //         ),
            //       ),
            //     ],
            //   );
            // }
          }
        }));
  }
}
