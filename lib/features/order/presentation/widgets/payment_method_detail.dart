import 'package:flutter/material.dart';
import 'package:pas_mobile/core/static/app_config.dart';
import 'package:pas_mobile/core/static/assets.dart';
import 'package:pas_mobile/core/static/colors.dart';
import 'package:pas_mobile/core/static/dimens.dart';
import 'package:pas_mobile/core/utility/enum.dart';
import 'package:pas_mobile/core/utility/extensions.dart';
import 'package:pas_mobile/core/utility/helper.dart';

class PaymentMethodDetailWidget extends StatelessWidget {
  final String paymentMethod;
  const PaymentMethodDetailWidget({Key? key, required this.paymentMethod})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (paymentMethod == PaymentMethod.cash.getString()) {
      return const Text(
        'Bayar dengan uang tunai pada saat pengiriman',
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: FONT_GENERAL,
            color: Colors.black),
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Selesaikan Pembayaran ke',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: FONT_GENERAL,
                color: Colors.black),
          ),
          smallVerticalSpacing(),
          SizedBox(
            width: double.infinity,
            child: Padding(
                padding: const EdgeInsets.only(
                    left: 10, top: 10, bottom: 10, right: 12),
                child: Column(
                  children: [
                    Container(
                      height: App(context).appHeight(5.5),
                      width: App(context).appWidth(60),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          color: bcaColors),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Image(
                              image: AssetImage(ASSES_BCA_ICON),
                            ),
                            smallHorizontalSpacing(),
                            const Text(
                              '0409178989',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: FONT_MEDIUM,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    smallVerticalSpacing(),
                    const Text(
                      'PT. PARAMA ASIA SEJAHTERA',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: FONT_GENERAL,
                          color: Colors.black),
                    ),
                  ],
                )),
          ),
        ],
      );
    }
  }
}
