import 'package:flutter/material.dart';
import 'package:pas_mobile/features/quick_order/presentation/providers/quick_product_refresh_state.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'providers/quick_order_provider.dart';
import 'widget/quick_order_item.dart';

class QuickOrderListSearch extends StatefulWidget {
  const QuickOrderListSearch({
    Key? key,
  }) : super(key: key);

  @override
  State<QuickOrderListSearch> createState() => _QuickOrderListSearchState();
}

class _QuickOrderListSearchState extends State<QuickOrderListSearch> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<QuickOrderProvider>(builder: (context, value, _) {
      if (value.productList.isNotEmpty) {
        return ListView.builder(
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
