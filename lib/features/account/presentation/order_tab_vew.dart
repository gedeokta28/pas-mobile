import 'package:flutter/material.dart';
import 'package:pas_mobile/core/utility/helper.dart';

import 'package:pas_mobile/features/account/presentation/widgets/order_item_card.dart';
import 'package:pas_mobile/features/order/presentation/providers/order_provider.dart';
import 'package:provider/provider.dart';

import '../../../core/static/app_config.dart';
import '../../../core/static/assets.dart';
import '../../order/presentation/order_detail_page.dart';
import '../../order/presentation/providers/list_oder_state.dart';

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
    return StreamBuilder<ListOrderState>(
        stream: context.read<OrderProvider>().fetchListOrder(),
        builder: (context, state) {
          switch (state.data.runtimeType) {
            case ListOrderLoading:
              return Center(
                child: Image.asset(
                  ASSETS_LOADING,
                  height: 100.0,
                  width: 100.0,
                ),
              );
            case ListOrderFailure:
              final failure = (state.data as ListOrderFailure).failure;
              final msg = getErrorMessage(failure);
              showShortToast(message: msg);
              return const SizedBox.shrink();
            case ListOrderSuccess:
              final _data = (state.data as ListOrderSuccess).listOrder;
              if (_data.isEmpty) {
                return const Center(
                    child: Text(
                  'Belum Memiliki Order',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                      color: Colors.grey),
                ));
              }
              return SingleChildScrollView(
                controller: _scrollController,
                child: Column(children: [
                  ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: _data.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, OrderDetailPage.routeName,
                                  arguments: OrderDetailPageArguments(
                                      orderId: _data[index].salesorderno,
                                      isFromCheckout: false));
                            },
                            child: OrderItemCard(orderData: _data[index]));
                      }),
                  largeVerticalSpacing()
                ]),
              );
          }
          return const SizedBox.shrink();
        });
  }
}
