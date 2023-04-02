import 'package:flutter/material.dart';
import 'package:pas_mobile/core/static/assets.dart';
import 'package:pas_mobile/core/static/dimens.dart';
import 'package:pas_mobile/core/utility/helper.dart';
import 'package:pas_mobile/features/order/presentation/widgets/order_detail_item_widget.dart';
import 'package:provider/provider.dart';

import '../../../cart/presentation/providers/cart_provider.dart';

class OrderDetailTopWidget extends StatelessWidget {
  const OrderDetailTopWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
        builder: (BuildContext context, provider, widget) {
      return Column(
        children: const [
          OrderDetailItemWidget(title: 'ID Order', detail: '#5491'),
          OrderDetailItemWidget(title: 'Tanggal Order', detail: '#5491'),
          OrderDetailItemWidget(title: 'Metode Pembayaran', detail: '#5491'),
          OrderDetailItemWidget(title: 'Email', detail: '#5491'),
        ],
      );
    });
  }
}
