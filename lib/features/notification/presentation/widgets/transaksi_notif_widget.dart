import 'package:flutter/material.dart';
import 'package:pas_mobile/core/static/colors.dart';
import 'package:pas_mobile/core/utility/helper.dart';
import 'package:pas_mobile/features/notification/data/models/order_notif_response_model.dart';

import '../../../../core/static/app_config.dart';

class TransaksiNotifWidget extends StatelessWidget {
  final Function? onTapBack;
  final OrderNotif orderNotif;

  const TransaksiNotifWidget(
      {Key? key, this.onTapBack, required this.orderNotif})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Container(
        color: greyColorTrans,
        width: double.infinity,
        height: App(context).appHeight(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: App(context).appWidth(80),
              child: Row(
                children: [
                  Container(
                    height: App(context).appHeight(10),
                    width: App(context).appWidth(27),
                    color: secondaryColor,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '#${orderNotif.data.orderId}',
                            style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 3.0,
                          ),
                          Text(
                            convertDate(orderNotif.createdAt),
                            style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white60,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  mediumHorizontalSpacing(),
                  Flexible(
                    child: Text(
                      orderNotif.data.message,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
                iconSize: 15,
                onPressed: () {},
                icon: const Icon(Icons.arrow_forward_ios_rounded))
          ],
        ),
      ),
    );
  }
}
