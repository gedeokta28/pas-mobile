import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../../core/static/colors.dart';
import '../../../../core/static/dimens.dart';

class PaymentTile extends StatelessWidget {
  final String assets;
  final String title;
  final Function onTap;
  final bool selected;

  const PaymentTile(
      {Key? key,
      required this.assets,
      required this.title,
      required this.selected,
      required this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    // return Consumer<HomeProvider>(builder: (context, provider, _) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: 8.0, bottom: 8.0, left: 0.0, right: 20.0),
            child: Image.asset(
              assets,
              width: 35,
            ),
          ),
          Flexible(
            flex: 5,
            fit: FlexFit.tight,
            child: AutoSizeText(
              title,
              style:
                  const TextStyle(fontSize: FONT_MEDIUM, color: Colors.black),
              minFontSize: 10,
              maxLines: 1,
            ),
          ),
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              selected
                  ? const Icon(
                      Icons.check,
                      color: primaryColor,
                      size: 30,
                    )
                  : const Text("")
            ],
          ))
        ],
      ),
      onTap: () => onTap(),
    );
    // });
  }
}
