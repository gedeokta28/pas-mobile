import 'package:flutter/material.dart';
import 'package:pas_mobile/core/static/colors.dart';
import 'package:pas_mobile/core/utility/helper.dart';

import '../../../../core/static/app_config.dart';

class TransaksiNotifWidget extends StatelessWidget {
  final Function? onTapBack;

  const TransaksiNotifWidget({Key? key, this.onTapBack}) : super(key: key);

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
            Container(
              width: App(context).appWidth(80),
              child: Row(
                children: [
                  Container(
                    height: App(context).appHeight(10),
                    width: App(context).appWidth(23),
                    color: secondaryColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          '#78789',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 3.0,
                        ),
                        const Text(
                          '07 Nov 2022',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.white60,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  mediumHorizontalSpacing(),
                  const Flexible(
                    child: Text(
                      'Order anda sedangOrder anda sedangOrder anda sedangOrder anda sedang',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
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
