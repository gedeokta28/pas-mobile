import 'package:flutter/material.dart';
import 'package:pas_mobile/core/static/assets.dart';
import 'package:pas_mobile/core/static/dimens.dart';
import 'package:pas_mobile/core/utility/helper.dart';

import '../../../../core/static/app_config.dart';
import '../../data/models/create_order_response_model.dart';

class OrderItemDetailWidget extends StatelessWidget {
  final ProductOrder productOrder;
  const OrderItemDetailWidget({Key? key, required this.productOrder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 5.0),
        child: Row(
          children: [
            productOrder.stock.images.isEmpty &&
                    productOrder.stock.photourl.isEmpty
                ? Image(
                    height: App(context).appWidth(15),
                    width: App(context).appWidth(15),
                    image: const AssetImage(ASSETS_PLACEHOLDER),
                  )
                : productOrder.stock.photourl.isNotEmpty
                    ? Image(
                        height: App(context).appWidth(15),
                        width: App(context).appWidth(15),
                        image: NetworkImage(productOrder.stock.photourl),
                      )
                    : productOrder.stock.images.isNotEmpty &&
                            productOrder.stock.photourl.isEmpty
                        ? Image(
                            height: App(context).appWidth(15),
                            width: App(context).appWidth(15),
                            image: NetworkImage(
                                productOrder.stock.images[0]['url']),
                          )
                        : Image(
                            height: App(context).appWidth(15),
                            width: App(context).appWidth(15),
                            image: const AssetImage(ASSETS_PLACEHOLDER),
                          ),
            smallHorizontalSpacing(),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productOrder.stockname,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: FONT_GENERAL),
                  ),
                  const SizedBox(height: 3.0),
                  Text(
                    '${productOrder.qtyorder}x  Rp. ${convertPrice(productOrder.price.toString())}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: FONT_GENERAL, color: Colors.black54),
                  ),
                  const SizedBox(height: 3.0),
                  Text(
                    'Total :  Rp. ${convertPrice(productOrder.nettotal.toString())}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: FONT_GENERAL,
                        color: Colors.black54),
                  ),
                ],
              ),
            ),

            // mediumHorizontalSpacing(),
          ],
        ));
  }
}
