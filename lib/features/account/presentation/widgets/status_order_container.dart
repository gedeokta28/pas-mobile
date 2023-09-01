import 'package:flutter/material.dart';
import 'package:pas_mobile/core/static/colors.dart';
import 'package:pas_mobile/core/utility/enum.dart';
import 'package:pas_mobile/core/utility/extensions.dart';

class StatusOrderContainer extends StatelessWidget {
  final String statusOrder;
  const StatusOrderContainer({Key? key, required this.statusOrder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (statusOrder == StatusOrder.paymentPending.getString() ||
        statusOrder == 'payment_pending') {
      return Container(
        color: pendingContainerColor,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            StatusOrder.paymentPending.toValue(),
            style: const TextStyle(
                color: pendingTextColor,
                fontSize: 13,
                fontWeight: FontWeight.bold),
          ),
        ),
      );
    } else if (statusOrder == StatusOrder.processing.getString()) {
      return Container(
        color: processingContainerColor,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            StatusOrder.processing.toValue(),
            style: const TextStyle(
                color: processingTextColor,
                fontSize: 13,
                fontWeight: FontWeight.bold),
          ),
        ),
      );
    } else if (statusOrder == StatusOrder.holdOn.getString()) {
      return Container(
        color: holdContainerColor,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            StatusOrder.holdOn.toValue(),
            style: const TextStyle(
                color: holdTextColor,
                fontSize: 13,
                fontWeight: FontWeight.bold),
          ),
        ),
      );
    } else if (statusOrder == StatusOrder.cancelled.getString()) {
      return Container(
        color: cancelContainerColor,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            StatusOrder.cancelled.toValue(),
            style: const TextStyle(
                color: cancelTextColor,
                fontSize: 13,
                fontWeight: FontWeight.bold),
          ),
        ),
      );
    } else {
      return Container(
        color: completedContainerColor,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            StatusOrder.completed.toValue(),
            style: const TextStyle(
                color: completedTextColor,
                fontSize: 13,
                fontWeight: FontWeight.bold),
          ),
        ),
      );
    }
  }
}
