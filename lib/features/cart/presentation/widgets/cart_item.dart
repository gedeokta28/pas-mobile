import 'package:flutter/material.dart';
import 'package:pas_mobile/core/static/app_config.dart';
import 'package:pas_mobile/core/static/assets.dart';
import 'package:pas_mobile/core/static/colors.dart';
import 'package:pas_mobile/core/static/dimens.dart';
import 'package:pas_mobile/core/utility/helper.dart';
import 'package:pas_mobile/features/cart/presentation/providers/add_cart_state.dart';
import 'package:provider/provider.dart';

import '../../../../core/presentation/widgets/custom_dialog_confirm.dart';
import '../providers/cart_provider.dart';

class CartItem extends StatelessWidget {
  final int index;
  const CartItem({Key? key, required this.index}) : super(key: key);

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
                      provider.cart[index].productName!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: FONT_GENERAL),
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  SizedBox(
                    width: App(context).appWidth(60),
                    child: Text(
                      'Rp. ${convertPrice((provider.cart[index].productPrice!.value * provider.cart[index].quantity!.value).toString())}',
                      maxLines: 1,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: FONT_GENERAL),
                    ),
                  ),
                  ValueListenableBuilder<int>(
                      valueListenable: provider.cart[index].quantity!,
                      builder: (context, val, child) {
                        return PlusMinusOrderButtons(
                          addQuantity: () {
                            provider.addQuantity(provider.cart[index].id!);
                            provider.addTotalPrice(double.parse(provider
                                .cart[index].productPrice!.value
                                .toString()));
                          },
                          deleteQuantity: () {
                            provider.deleteQuantity(provider.cart[index].id!);
                            provider.removeTotalPrice(double.parse(provider
                                .cart[index].productPrice!.value
                                .toString()));
                          },
                          changeQuantity: (val) {
                            provider.changeQuantity(
                                provider.cart[index].id!, val);
                          },
                          text: val.toString(),
                        );
                      }),
                ],
              ),
              IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => CustomConfirmDialog(
                        positiveAction: () async {
                          showLoading();
                          provider
                              .deleteProductCart(provider.cart[index].id!)
                              .listen((event) {
                            if (event is AddToCartSuccess) {
                              provider.removeItem(provider.cart[index].id!);
                              provider.removeCounter();
                              dismissLoading();
                              Navigator.pop(context);
                            }
                          });
                        },
                        title: "Hapus Produk Ini Dari Keranjang ?",
                      ),
                    );
                  },
                  icon: const Icon(
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
            width: App(context).appWidth(15),
            height: App(context).appWidth(7),
            decoration: BoxDecoration(
              border: Border.all(color: secondaryColor),
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
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

class PlusMinusOrderButtons extends StatelessWidget {
  final VoidCallback deleteQuantity;
  final VoidCallback addQuantity;
  final Function(String val) changeQuantity;
  final String text;
  const PlusMinusOrderButtons(
      {Key? key,
      required this.addQuantity,
      required this.deleteQuantity,
      required this.changeQuantity,
      required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TextEditingController _textEditingController =
    //     TextEditingController(text: text);
    final TextEditingController _textEditingController =
        TextEditingController.fromValue(TextEditingValue(
            text: text,
            selection: TextSelection.collapsed(offset: text.length)));
    return Row(
      children: [
        IconButton(
          onPressed: deleteQuantity,
          icon: Image.asset(MINUS_ICON),
          color: secondaryColor,
        ),
        Container(
            width: App(context).appWidth(15),
            height: App(context).appWidth(7),
            decoration: BoxDecoration(
              border: Border.all(color: secondaryColor),
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
            ),
            child: Center(
                child:
                    //     Text(
                    //   text,
                    //   style: const TextStyle(
                    //       fontWeight: FontWeight.bold, fontSize: FONT_GENERAL),
                    // )
                    TextField(
                        textAlign: TextAlign.center,
                        controller: _textEditingController,
                        onSubmitted: (val) {
                          changeQuantity(val);
                        },
                        onChanged: (val) {
                          changeQuantity(val);
                        },
                        keyboardType: TextInputType.number,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: FONT_GENERAL),
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(0.0),
                          border: InputBorder.none,
                          isDense: true,
                        )))),
        IconButton(
            onPressed: addQuantity,
            icon: Image.asset(PLUS_ICON),
            color: secondaryColor),
      ],
    );
  }
}
