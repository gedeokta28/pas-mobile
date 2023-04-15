import 'package:flutter/material.dart';
import 'package:pas_mobile/core/static/app_config.dart';
import 'package:pas_mobile/core/static/assets.dart';
import 'package:pas_mobile/core/static/dimens.dart';
import 'package:pas_mobile/core/utility/extensions.dart';
import 'package:pas_mobile/core/utility/helper.dart';
import 'package:pas_mobile/features/order/presentation/providers/order_provider.dart';
import 'package:pas_mobile/features/order/presentation/widgets/payment_tile_widget.dart';
import 'package:provider/provider.dart';

import '../../../../core/utility/enum.dart';

class PaymentMethodWidget extends StatelessWidget {
  const PaymentMethodWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(
        builder: (BuildContext context, provider, widget) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Metode Pembayaran',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: FONT_GENERAL,
                color: Colors.black),
          ),
          smallVerticalSpacing(),
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return SizedBox(
                      height: App(context).appHeight(25),
                      child: LayoutBuilder(builder: (context, constaints) {
                        return ListView(
                          children: [
                            smallVerticalSpacing(),
                            SizedBox(
                              height: constaints.maxHeight * 0.25,
                              child: const Padding(
                                padding: EdgeInsets.only(
                                    top: 8.0, left: 15.0, bottom: 0.0),
                                child: Text(
                                  'Pilih Metode Pembayaran',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: FONT_MEDIUM,
                                      color: Colors.black),
                                ),
                              ),
                            ),
                            SizedBox(
                                height: constaints.maxHeight * 0.30,
                                child: PaymentTile(
                                  title: 'Cash On Delivery',
                                  assets: ASSET_COD_ICON,
                                  onTap: () {
                                    provider.setPaymentMethod =
                                        PaymentMethod.cash;
                                    Navigator.pop(context);
                                  },
                                  selected: provider.paymentMethod == null
                                      ? false
                                      : provider.paymentMethod ==
                                              PaymentMethod.cash
                                          ? true
                                          : false,
                                )),
                            SizedBox(
                                height: constaints.maxHeight * 0.30,
                                child: PaymentTile(
                                  title: 'Bank Transfer',
                                  assets: ASSET_TRASNFER_ICON,
                                  onTap: () {
                                    provider.setPaymentMethod =
                                        PaymentMethod.trasnfer;
                                    Navigator.pop(context);
                                  },
                                  selected: provider.paymentMethod == null
                                      ? false
                                      : provider.paymentMethod ==
                                              PaymentMethod.trasnfer
                                          ? true
                                          : false,
                                )),
                            mediumVerticalSpacing(),
                          ],
                        );
                      }),
                    );
                  });
            },
            child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black45, width: 0.5),
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 10, top: 10, bottom: 10, right: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      provider.paymentMethod == null
                          ? const Icon(
                              Icons.payment,
                              color: Colors.black,
                            )
                          : provider.paymentMethod == PaymentMethod.trasnfer
                              ? Image.asset(
                                  ASSET_TRASNFER_ICON,
                                  width: 22,
                                )
                              : Image.asset(
                                  ASSET_COD_ICON,
                                  width: 25,
                                ),
                      smallHorizontalSpacing(),
                      Flexible(
                        flex: 5,
                        fit: FlexFit.tight,
                        child: Text(
                          provider.paymentMethod == null
                              ? 'Pilih Metode Pembayaran'
                              : provider.paymentMethod!.getString(),
                          style: TextStyle(
                              color: provider.paymentMethod == null
                                  ? Colors.grey
                                  : Colors.black),
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black,
                        size: 15,
                      ),
                    ],
                  ),
                )),
          )
        ],
      );
    });
  }
}
