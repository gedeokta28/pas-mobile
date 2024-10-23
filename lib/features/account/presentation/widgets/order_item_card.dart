import 'package:flutter/material.dart';
import 'package:pas_mobile/core/static/app_config.dart';
import 'package:pas_mobile/core/utility/helper.dart';
import 'package:pas_mobile/features/account/presentation/widgets/status_order_container.dart';
import 'package:pas_mobile/features/order/data/models/order_list_model.dart';

import '../../../../core/static/assets.dart';

class OrderItemCard extends StatelessWidget {
  final OrderDataList orderData;
  const OrderItemCard({Key? key, required this.orderData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Card(
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    mergeOrderText(
                        orderData.salesorderno, orderData.salesorderdate),
                    style: const TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                  StatusOrderContainer(statusOrder: orderData.status)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    orderData.deliveryto,
                    // "${orderData.customerOrder.customerid} (${orderData.deliveryto})",
                    style: const TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ],
              ),
              smallVerticalSpacing(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  orderData.products[0].stock.images.isEmpty &&
                          orderData.products[0].stock.photourl.isEmpty
                      ? Image(
                          height: App(context).appWidth(20),
                          width: App(context).appWidth(20),
                          image: const AssetImage(ASSETS_PLACEHOLDER),
                        )
                      : orderData.products[0].stock.photourl.isNotEmpty
                          ? Image.network(orderData.products[0].stock.photourl,
                              fit: BoxFit.cover,
                              height: App(context).appWidth(20),
                              width: App(context).appWidth(20),
                              errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                ASSETS_PLACEHOLDER,
                                height: App(context).appWidth(20),
                                width: App(context).appWidth(20),
                                fit: BoxFit.cover,
                              );
                            })
                          : orderData.products[0].stock.images.isNotEmpty &&
                                  orderData.products[0].stock.photourl.isEmpty
                              ? Image.network(
                                  orderData.products[0].stock.images[0]['url'],
                                  fit: BoxFit.cover,
                                  height: App(context).appWidth(20),
                                  width: App(context).appWidth(20),
                                  errorBuilder: (context, error, stackTrace) {
                                  return Image.asset(
                                    ASSETS_PLACEHOLDER,
                                    height: App(context).appWidth(20),
                                    width: App(context).appWidth(20),
                                    fit: BoxFit.cover,
                                  );
                                })
                              : Image(
                                  height: App(context).appWidth(20),
                                  width: App(context).appWidth(20),
                                  image: const AssetImage(ASSETS_PLACEHOLDER),
                                ),
                  smallHorizontalSpacing(),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          orderData.products[0].stockname,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '${orderData.products.length} produk',
                          style: const TextStyle(
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Qty : ${orderData.products[0].qtyorder}',
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            const Text(
                              'Total : ',
                              style: TextStyle(fontSize: 13),
                            ),
                            Row(
                              children: [
                                const Text(
                                  'Rp',
                                  style: TextStyle(
                                      fontSize: 11.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                Text(
                                  convertPrice(orderData.salesordergrandtotal
                                      .toString()),
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
