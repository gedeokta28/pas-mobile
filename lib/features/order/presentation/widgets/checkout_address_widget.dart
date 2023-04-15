import 'package:flutter/material.dart';
import 'package:pas_mobile/core/static/colors.dart';
import 'package:pas_mobile/core/utility/helper.dart';
import 'package:pas_mobile/features/order/presentation/providers/order_provider.dart';
import 'package:pas_mobile/features/order/presentation/select_checkout_address_page.dart';
import 'package:pas_mobile/features/order/presentation/widgets/address_card_checkout.dart';

import 'package:provider/provider.dart';

import '../../../../core/static/dimens.dart';

class CheckoutAddressWidget extends StatelessWidget {
  const CheckoutAddressWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(
        builder: (BuildContext context, provider, widget) {
      if (provider.shippingAddressSelected == null) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            smallVerticalSpacing(),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, AddressCheckoutPage.routeName)
                    .then((_) {
                  logMe(provider.shippingAddressSelected!.addressDetail);
                });
              },
              child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: secondaryColor, width: 0.5),
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 10, top: 10, bottom: 10, right: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          'Pilih Alamat',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: FONT_GENERAL,
                              color: Colors.black54),
                        )
                      ],
                    ),
                  )),
            )
          ],
        );
      } else {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Alamat Pengiriman',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: FONT_GENERAL,
                  color: Colors.black),
            ),
            const SizedBox(height: 8.0),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, AddressCheckoutPage.routeName)
                    .then((_) {
                  logMe(provider.shippingAddressSelected!.addressDetail);
                });
              },
              child: AddressCardCheckout(
                  shippingAddress: provider.shippingAddressSelected!),
            ),
          ],
        );
      }
    });
  }
}
