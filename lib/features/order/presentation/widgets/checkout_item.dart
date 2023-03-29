import 'package:flutter/material.dart';
import 'package:pas_mobile/core/static/assets.dart';
import 'package:pas_mobile/core/static/dimens.dart';
import 'package:pas_mobile/core/utility/helper.dart';
import 'package:provider/provider.dart';

import '../../../cart/presentation/providers/cart_provider.dart';

class CheckoutItem extends StatelessWidget {
  final int index;
  const CheckoutItem({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Consumer<CartProvider>(
          builder: (BuildContext context, provider, widget) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            provider.cart[index].image!.isNotEmpty
                ? Image(
                    height: 40,
                    width: 40,
                    image: NetworkImage(provider.cart[index].image!),
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
                provider.cart[index].productName!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: FONT_GENERAL),
              ),
            ),
            Text(
              '${provider.cart[index].quantity!.value.toString()}x',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: FONT_GENERAL,
                  color: Colors.black54),
            ),
            mediumHorizontalSpacing(),
            Text(
              'Rp. ${convertPrice(provider.cart[index].productPrice!.value.toString())}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: FONT_GENERAL,
                  color: Colors.black54),
            ),
          ],
        );
      }),
    );
  }
}
