import 'package:flutter/material.dart';

import '../../cart/data/models/price_grosir_model.dart';

class ProductQuick {
  late final String id;
  final String? productId;
  final String productName;
  final int? initialPrice;
  final ValueNotifier<int>? productPrice;
  final ValueNotifier<int>? quantity;
  final String? unitTag;
  final String? image;
  final String? qty1;
  final String? qty2;
  final String? qty3;
  final String? unit1;
  final String? unit2;
  final String? unit3;
  final String? hrg1;
  final String? hrg2;
  final String? hrg3;
  final String? disclist1;
  final String? disclist2;
  final String? disclist3;

  final List<PriceGrosirCart>? priceGrosirProductQuick;

  ProductQuick({
    required this.id,
    required this.productId,
    required this.productName,
    required this.initialPrice,
    required this.productPrice,
    required this.quantity,
    required this.unitTag,
    required this.image,
    required this.priceGrosirProductQuick,
    required this.qty1,
    required this.qty2,
    required this.qty3,
    required this.unit1,
    required this.unit2,
    required this.unit3,
    required this.hrg1,
    required this.hrg2,
    required this.hrg3,
    required this.disclist1,
    required this.disclist2,
    required this.disclist3,
  });

  ProductQuick.fromMap(Map<dynamic, dynamic> data)
      : id = data['id'],
        productId = data['productId'],
        productName = data['productName'],
        initialPrice = data['initialPrice'],
        productPrice = ValueNotifier(data['productPrice']),
        quantity = ValueNotifier(data['quantity']),
        unitTag = data['unitTag'],
        image = data['image'],
        priceGrosirProductQuick = data['priceGrosirProductQuick'],
        qty1 = data['qty1'],
        qty2 = data['qty2'],
        qty3 = data['qty3'],
        unit1 = data['unit1'],
        unit2 = data['unit2'],
        unit3 = data['unit3'],
        hrg1 = data['hrg1'],
        hrg2 = data['hrg2'],
        hrg3 = data['hrg3'],
        disclist1 = data['disclist1'],
        disclist2 = data['disclist2'],
        disclist3 = data['disclist3'];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productId': productId,
      'productName': productName,
      'initialPrice': initialPrice,
      'productPrice': productPrice,
      'quantity': quantity?.value,
      'unitTag': unitTag,
      'image': image,
      'priceGrosirProductQuick': priceGrosirProductQuick,
      'qty1': qty1,
      'qty2': qty2,
      'qty3': qty3,
      'unit1': unit1,
      'unit2': unit2,
      'unit3': unit3,
      'disclist1': disclist1,
      'disclist2': disclist2,
      'disclist3': disclist3,
    };
  }
}
