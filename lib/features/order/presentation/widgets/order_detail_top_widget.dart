import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pas_mobile/features/order/data/models/create_order_response_model.dart';
import 'package:pas_mobile/features/order/presentation/widgets/order_detail_item_widget.dart';

import '../../../../core/static/dimens.dart';

class OrderDetailTopWidget extends StatelessWidget {
  final DetailOrder detailOrder;
  final bool isFromCheckout;
  final String orderStatus;
  const OrderDetailTopWidget(
      {Key? key,
      required this.detailOrder,
      this.isFromCheckout = true,
      this.orderStatus = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isFromCheckout) {
      return Column(
        children: [
          OrderDetailItemWidget(
              title: 'ID Order', detail: '#${detailOrder.salesorderno}'),
          OrderDetailItemWidget(
              title: 'Tanggal Order',
              detail:
                  DateFormat('d MMMM yyyy').format(detailOrder.salesorderdate)),
          OrderDetailItemWidget(
              title: 'Metode Pembayaran', detail: detailOrder.paymentype),
        ],
      );
    }
    return Column(
      children: [
        OrderDetailItemWidget(
            title: 'ID Order', detail: '#${detailOrder.salesorderno}'),
        OrderDetailItemWidget(
            title: 'Tanggal Order',
            detail:
                DateFormat('d MMMM yyyy').format(detailOrder.salesorderdate)),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Status',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: FONT_GENERAL, color: Colors.black87),
              ),
              Container(
                color: Colors.grey[400],
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    orderStatus,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
