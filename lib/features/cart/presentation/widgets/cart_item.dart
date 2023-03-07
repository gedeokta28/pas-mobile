import 'package:flutter/material.dart';
import 'package:pas_mobile/core/static/app_config.dart';
import 'package:pas_mobile/core/static/assets.dart';
import 'package:pas_mobile/core/static/colors.dart';
import 'package:pas_mobile/core/static/dimens.dart';
import 'package:pas_mobile/core/utility/helper.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';

class CartItem extends StatelessWidget {
  int index;
  CartItem({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
        builder: (BuildContext context, provider, widget) {
      return Card(
        elevation: 1.0,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              provider.cart[index].image!.isNotEmpty
                  ? Image(
                      height: 80,
                      width: 80,
                      image: NetworkImage(provider.cart[index].image!),
                    )
                  : const Image(
                      height: 80,
                      width: 80,
                      image: AssetImage(ASSETS_PLACEHOLDER),
                    ),
              smallHorizontalSpacing(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: App(context).appWidth(60),
                    child: Text(
                      '${provider.cart[index].productName!}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: FONT_GENERAL),
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    width: App(context).appWidth(60),
                    child: Text(
                      'Rp. ${provider.cart[index].productPrice!}',
                      maxLines: 1,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: FONT_GENERAL),
                    ),
                  ),
                  ValueListenableBuilder<int>(
                      valueListenable: provider.cart[index].quantity!,
                      builder: (context, val, child) {
                        return PlusMinusButtons(
                          addQuantity: () {
                            provider.addQuantity(provider.cart[index].id!);
                            provider.addTotalPrice(double.parse(
                                provider.cart[index].productPrice.toString()));
                          },
                          deleteQuantity: () {
                            provider.deleteQuantity(provider.cart[index].id!);
                            provider.removeTotalPrice(double.parse(
                                provider.cart[index].productPrice.toString()));
                          },
                          text: val.toString(),
                        );
                      }),
                ],
              ),
              IconButton(
                  onPressed: () {
                    provider.removeItem(provider.cart[index].id!);
                    provider.removeCounter();
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Colors.black54,
                  )),
            ],
          ),
        ),
      );
    });
  }
}

class PlusMinusButtons extends StatelessWidget {
  final VoidCallback deleteQuantity;
  final VoidCallback addQuantity;
  final String text;
  const PlusMinusButtons(
      {Key? key,
      required this.addQuantity,
      required this.deleteQuantity,
      required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: deleteQuantity,
          icon: Image.asset(MINUS_ICON),
          color: secondaryColor,
        ),
        Container(
            width: App(context).appWidth(8),
            height: App(context).appWidth(6),
            decoration: BoxDecoration(
              border: Border.all(color: secondaryColor),
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
            child: Center(
                child: Text(
              text,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: FONT_GENERAL),
            ))),
        IconButton(
            onPressed: addQuantity,
            icon: Image.asset(PLUS_ICON),
            color: secondaryColor),
      ],
    );
  }
}
