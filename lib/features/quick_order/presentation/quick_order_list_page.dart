import 'package:flutter/material.dart';
import 'package:pas_mobile/features/quick_order/presentation/providers/quick_product_refresh_state.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'providers/quick_order_provider.dart';
import 'widget/quick_order_item.dart';

class QuickOrderList extends StatefulWidget {
  const QuickOrderList({
    Key? key,
  }) : super(key: key);

  @override
  State<QuickOrderList> createState() => _QuickOrderListState();
}

class _QuickOrderListState extends State<QuickOrderList> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  late QuickOrderProvider _provider;
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
    return Consumer<QuickOrderProvider>(builder: (context, value, _) {
      _provider = value;
      if (value.productList.isNotEmpty) {
        return SmartRefresher(
          controller: _refreshController,
          enablePullDown: false,
          enablePullUp: true,
          onLoading: _onLoading,
          child: ListView.builder(
            key: _scaffoldKey,
            shrinkWrap: true,
            itemCount: value.quickOrderProduct.length,
            itemBuilder: (context, index) {
              return QuickOrderItem(
                // product: value.productList[index],
                onSelect: () {
                  if (value.isDataExist(value.quickOrderProduct[index].id)) {
                    value.removeSelectedProduct(value.quickOrderProduct[index]);
                  } else {
                    value.addSelectedProduct(value.quickOrderProduct[index]);
                  }
                },
                index: index,
                valueSelected:
                    value.isDataExist(value.quickOrderProduct[index].id),
              );
            },
          ),
        );
      } else {
        return const Center(
          child: Text(
            'Belum Ada Produk',
          ),
        );
      }
    });
  }
}
