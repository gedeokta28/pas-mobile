import 'package:flutter/material.dart';
import 'package:pas_mobile/core/static/dimens.dart';
import 'package:provider/provider.dart';

class OrderDetailItemWidget extends StatelessWidget {
  final String title;
  final String detail;
  const OrderDetailItemWidget(
      {Key? key, required this.title, required this.detail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: FONT_GENERAL, color: Colors.black87),
          ),
          Text(
            detail,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: FONT_GENERAL,
                color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
