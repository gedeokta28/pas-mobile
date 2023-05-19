import 'package:flutter/material.dart';
import 'package:pas_mobile/core/static/colors.dart';
import 'package:provider/provider.dart';

import '../../../../core/static/app_config.dart';
import '../../../../core/static/assets.dart';
import '../../../../core/static/dimens.dart';
import '../../../../core/utility/helper.dart';
import '../../../cart/presentation/widgets/cart_item.dart';
import '../../../home/data/models/product_list_response_model.dart';
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
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: FONT_GENERAL),
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                SizedBox(
                  width: App(context).appWidth(35),
                  child: Column(
                    children: [
                      Container(
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
                              Text(
                                '1',
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
                                    convertPrice('2000'),
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
                      Container(
                        height: 25,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '2',
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
                                    convertPrice('1900'),
                                    style: const TextStyle(
                                        fontSize: 13,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
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
                              Text(
                                '3',
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
                                    convertPrice('2300'),
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
                    ],
                  ),
                ),
                ValueListenableBuilder<int>(
                    valueListenable: value.quickOrderProduct[index].quantity!,
                    builder: (context, val, child) {
                      return PlusMinusButtons(
                        addQuantity: () {
                          value.addQuantity(value.quickOrderProduct[index].id);
                        },
                        deleteQuantity: () {},
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
