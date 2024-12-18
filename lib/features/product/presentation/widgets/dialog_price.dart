import 'package:flutter/material.dart';
import 'package:pas_mobile/core/static/colors.dart';
import 'package:pas_mobile/features/home/data/models/variant_product_response_model.dart';

import '../../../../core/presentation/widgets/components/dialog_container.dart';
import '../../../../core/utility/helper.dart';
import '../../../home/data/models/detail_product_model.dart';

class DialogPrice {
  static Future<bool?> displayDialogOKCallBack(
    BuildContext context,
    String title,
    ProductDetail productDetail,
  ) async {
    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: SingleChildScrollView(
              child: DialogContainer(
                customPadding: const EdgeInsets.all(10),
                withMargin: true,
                child: Column(
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87),
                    ),
                    smallVerticalSpacing(),
                    productDetail.qty1 == '0'
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
                                        satuan1: productDetail.unit1,
                                        satuan2: productDetail.unit2,
                                        satuan3: productDetail.unit3,
                                        qty1: productDetail.qty1,
                                        qty2: productDetail.qty2,
                                        qty3: productDetail.qty3),
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
                                        convertPriceDisc(productDetail.hrg1,
                                            productDetail.disclist1),
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
                    const SizedBox(height: 5),
                    productDetail.qty2 == '0'
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
                                        satuan1: productDetail.unit1,
                                        satuan2: productDetail.unit2,
                                        satuan3: productDetail.unit3,
                                        qty1: productDetail.qty1,
                                        qty2: productDetail.qty2,
                                        qty3: productDetail.qty3),
                                    style: const TextStyle(
                                        fontSize: 13,
                                        color: Colors.black,
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
                                            color: Colors.black),
                                      ),
                                      Text(
                                        convertPriceDisc(productDetail.hrg1,
                                            productDetail.disclist2),
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
                    const SizedBox(height: 5),
                    productDetail.qty3 == '0'
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
                                        satuan1: productDetail.unit1,
                                        satuan2: productDetail.unit2,
                                        satuan3: productDetail.unit3,
                                        qty1: productDetail.qty1,
                                        qty2: productDetail.qty2,
                                        qty3: productDetail.qty3),
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
                                        convertPriceDisc(productDetail.hrg1,
                                            productDetail.disclist3),
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
            ),
          ),
        );
      },
    );
  }
}

class DialogPriceVariant {
  static Future<bool?> displayDialogOKCallBack(
    BuildContext context,
    String title,
    ProductVariant productDetail,
  ) async {
    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: SingleChildScrollView(
              child: DialogContainer(
                customPadding: const EdgeInsets.all(10),
                withMargin: true,
                child: Column(
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87),
                    ),
                    smallVerticalSpacing(),
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
                              convertStrUnitVariant(
                                  hrg: 1,
                                  satuan1: productDetail.unit1,
                                  satuan2: productDetail.unit2,
                                  satuan3: productDetail.unit3,
                                  qty1: productDetail.qty1,
                                  qty2: productDetail.qty2,
                                  qty3: productDetail.qty3),
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
                                  convertPrice(productDetail.hrg1),
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
                              convertStrUnit(
                                  hrg: 2,
                                  satuan1: productDetail.unit1,
                                  satuan2: productDetail.unit2,
                                  satuan3: productDetail.unit3,
                                  qty1: productDetail.qty1,
                                  qty2: productDetail.qty2,
                                  qty3: productDetail.qty3),
                              style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.black,
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
                                      color: Colors.black),
                                ),
                                Text(
                                  convertPrice(productDetail.hrg2),
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
                              convertStrUnit(
                                  hrg: 3,
                                  satuan1: productDetail.unit1,
                                  satuan2: productDetail.unit2,
                                  satuan3: productDetail.unit3,
                                  qty1: productDetail.qty1,
                                  qty2: productDetail.qty2,
                                  qty3: productDetail.qty3),
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
                                  convertPrice(productDetail.hrg3),
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
            ),
          ),
        );
      },
    );
  }
}
