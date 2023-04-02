import 'package:flutter/material.dart';
import 'package:pas_mobile/core/static/assets.dart';
import 'package:pas_mobile/core/static/dimens.dart';
import 'package:pas_mobile/core/utility/helper.dart';
import 'package:provider/provider.dart';

import '../../../cart/data/models/cart_list_model.dart';
import '../../../cart/presentation/providers/cart_provider.dart';

class OrderItemWidget extends StatelessWidget {
  final ItemCart itemCart;
  const OrderItemWidget({Key? key, required this.itemCart}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            itemCart.stock.images.isNotEmpty
                ? Image(
                    height: 40,
                    width: 40,
                    image: NetworkImage(itemCart.stock.images[0]),
                  )
                : const Image(
                    height: 40,
                    width: 40,
                    image: AssetImage(ASSETS_PLACEHOLDER),
                  ),
            smallHorizontalSpacing(),
            Expanded(
              flex: 2,
              child: Text(
                itemCart.stock.stockname,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: FONT_GENERAL),
              ),
            ),
            Text(
              '${itemCart.qty}x',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: FONT_GENERAL,
                  color: Colors.black54),
            ),
            mediumHorizontalSpacing(),
            Text(
              'Rp. ${convertPrice(itemCart.stock.hrg1.toString())}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: FONT_GENERAL,
                  color: Colors.black54),
            ),
          ],
        ));
  }
}
