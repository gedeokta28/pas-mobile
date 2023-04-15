import 'package:flutter/material.dart';

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
            if (provider.listOrder.isEmpty) {
              return const Center(
                  child: Text(
                'Belum Memiliki Pesanan',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                    color: Colors.grey),
              ));
            } else {
              return Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: RefreshIndicator(
                  onRefresh: provider.refreshData,
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, OrderDetailPage.routeName,
                                arguments: OrderDetailPageArguments(
                                    orderId:
                                        provider.listOrder[index].salesorderno,
                                    isFromCheckout: false));
                          },
                          child: OrderItemCard(
                              orderData: provider.listOrder[index]));
                    },
                    itemCount: provider.listOrder.length,
                  ),
                ),
              );
            }
          }
        }));
  }
}
