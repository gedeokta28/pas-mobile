import 'package:flutter/material.dart';
import 'package:pas_mobile/core/static/colors.dart';
import 'package:provider/provider.dart';

import '../../../../core/static/app_config.dart';
import '../../../../core/static/assets.dart';
import '../../../../core/static/dimens.dart';
import '../../../../core/utility/helper.dart';
import '../../../cart/presentation/widgets/cart_item.dart';
import '../providers/quick_order_provider.dart';

class QuickOrderItem extends StatelessWidget {
  // final Product product;
  final Function onSelect;
  final int index;
  final bool valueSelected;

  const QuickOrderItem(
      {Key? key,
      // required this.product,
      required this.index,
      required this.onSelect,
      required this.valueSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<QuickOrderProvider>(builder: (context, value, _) {
      return Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        margin: const EdgeInsets.only(bottom: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(
              width: 10.0,
            ),
            value.quickOrderProduct[index].image!.isNotEmpty
                ? Image(
                    height: 80,
                    width: 80,
                    image: NetworkImage(value.quickOrderProduct[index].image!),
                  )
                : const Image(
                    height: 80,
                    width: 80,
                    image: AssetImage(ASSETS_PLACEHOLDER),
                  ),
            mediumHorizontalSpacing(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 5.0,
                ),
                SizedBox(
                  width: App(context).appWidth(55),
                  child: Text(
                    value.quickOrderProduct[index].productName,
                    maxLines: 2,
                    // overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),
                const SizedBox(
                  height: 3.0,
                ),
                value.quickOrderProduct[index].qty1! == '0.00' &&
                        value.quickOrderProduct[index].qty2 == '0.00' &&
                        value.quickOrderProduct[index].qty3 == '0.00'
                    ? SizedBox(
                        width: App(context).appWidth(50),
                        child: Container(
                          height: 25,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: secondaryColor),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      'Rp',
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontSize: 11.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    Text(
                                      convertPriceDisc(
                                          value.quickOrderProduct[index].hrg1!,
                                          value.quickOrderProduct[index]
                                              .disclist1!),
                                      style: const TextStyle(
                                          fontSize: 13,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : SizedBox(
                        width: App(context).appWidth(50),
                        child: Column(
                          children: [
                            value.quickOrderProduct[index].qty1 == '0.00'
                                ? const SizedBox()
                                : Container(
                                    height: 25,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(3),
                                        color: secondaryColor),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            getQuantity(
                                                hrg: 1,
                                                satuan1: value
                                                    .quickOrderProduct[index]
                                                    .unit1!,
                                                satuan2: value
                                                    .quickOrderProduct[index]
                                                    .unit2!,
                                                satuan3: value
                                                    .quickOrderProduct[index]
                                                    .unit3!,
                                                qty1: value
                                                    .quickOrderProduct[index]
                                                    .qty1!,
                                                qty2: value
                                                    .quickOrderProduct[index]
                                                    .qty2!,
                                                qty3: value
                                                    .quickOrderProduct[index]
                                                    .qty3!),
                                            style: const TextStyle(
                                                fontSize: 13,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Row(
                                            children: [
                                              const Text(
                                                'Rp',
                                                maxLines: 1,
                                                style: TextStyle(
                                                    fontSize: 11.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                              Text(
                                                convertPriceDisc(
                                                    value
                                                        .quickOrderProduct[
                                                            index]
                                                        .hrg1!,
                                                    value
                                                        .quickOrderProduct[
                                                            index]
                                                        .disclist1!),
                                                style: const TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                            const SizedBox(height: 3),
                            value.quickOrderProduct[index].qty2 == '0.00'
                                ? const SizedBox()
                                : Container(
                                    height: 25,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(3),
                                        color: Colors.white),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            getQuantity(
                                                hrg: 2,
                                                satuan1: value
                                                    .quickOrderProduct[index]
                                                    .unit1!,
                                                satuan2: value
                                                    .quickOrderProduct[index]
                                                    .unit2!,
                                                satuan3: value
                                                    .quickOrderProduct[index]
                                                    .unit3!,
                                                qty1: value
                                                    .quickOrderProduct[index]
                                                    .qty1!,
                                                qty2: value
                                                    .quickOrderProduct[index]
                                                    .qty2!,
                                                qty3: value
                                                    .quickOrderProduct[index]
                                                    .qty3!),
                                          ),
                                          Row(
                                            children: [
                                              const Text(
                                                'Rp',
                                                maxLines: 1,
                                                style: TextStyle(
                                                    fontSize: 11.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                              ),
                                              Text(
                                                convertPriceDisc(
                                                    value
                                                        .quickOrderProduct[
                                                            index]
                                                        .hrg1!,
                                                    value
                                                        .quickOrderProduct[
                                                            index]
                                                        .disclist2!),
                                                style: const TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                            const SizedBox(height: 3),
                            value.quickOrderProduct[index].qty3 == '0.00'
                                ? const SizedBox()
                                : Container(
                                    height: 25,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(3),
                                        color: secondaryColor),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            getQuantity(
                                                hrg: 3,
                                                satuan1: value
                                                    .quickOrderProduct[index]
                                                    .unit1!,
                                                satuan2: value
                                                    .quickOrderProduct[index]
                                                    .unit2!,
                                                satuan3: value
                                                    .quickOrderProduct[index]
                                                    .unit3!,
                                                qty1: value
                                                    .quickOrderProduct[index]
                                                    .qty1!,
                                                qty2: value
                                                    .quickOrderProduct[index]
                                                    .qty2!,
                                                qty3: value
                                                    .quickOrderProduct[index]
                                                    .qty3!),
                                            style: const TextStyle(
                                                fontSize: 13,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Row(
                                            children: [
                                              const Text(
                                                'Rp',
                                                maxLines: 1,
                                                style: TextStyle(
                                                    fontSize: 11.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                              Text(
                                                convertPriceDisc(
                                                    value
                                                        .quickOrderProduct[
                                                            index]
                                                        .hrg1!,
                                                    value
                                                        .quickOrderProduct[
                                                            index]
                                                        .disclist3!),
                                                style: const TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                ValueListenableBuilder<int>(
                    valueListenable: value.quickOrderProduct[index].quantity!,
                    builder: (context, val, child) {
                      return PlusMinusOrderButtons(
                        addQuantity: () {
                          value.addQuantity(value.quickOrderProduct[index].id);
                        },
                        deleteQuantity: () {
                          value.deleteQuantity(
                              value.quickOrderProduct[index].id);
                        },
                        changeQuantity: (val) {
                          value.changeQuantity(
                              value.quickOrderProduct[index].id, val);
                        },
                        text: val.toString(),
                      );
                    }),
              ],
            ),
            Expanded(
              child: Theme(
                data: ThemeData(unselectedWidgetColor: secondaryColor),
                child: Padding(
                  padding: const EdgeInsets.only(right: 5.0),
                  child: CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    title: null,
                    value: valueSelected,
                    onChanged: (_) {
                      FocusScope.of(context).requestFocus(FocusNode());
                      onSelect();
                    },
                    checkColor: Colors.white,
                    activeColor: secondaryColor,
                    controlAffinity: ListTileControlAffinity.platform,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
