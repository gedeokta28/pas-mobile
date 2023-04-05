import 'package:flutter/material.dart';
import 'package:pas_mobile/core/static/dimens.dart';

import '../../../../core/utility/helper.dart';

class OrderDetailItemWidget extends StatelessWidget {
  final String title;
  final String detail;
  final bool isPrice;
  const OrderDetailItemWidget(
      {Key? key,
      required this.title,
      required this.detail,
      this.isPrice = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style:
                const TextStyle(fontSize: FONT_GENERAL, color: Colors.black87),
          ),
          isPrice
              ? Text(
                  'Rp. ${convertPrice(detail)}',
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: FONT_GENERAL,
                      fontWeight: FontWeight.bold),
                )
              : Text(
                  detail,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: FONT_GENERAL,
                      color: Colors.grey),
                ),
        ],
      ),
    );
  }
}
