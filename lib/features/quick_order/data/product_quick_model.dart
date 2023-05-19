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
        priceGrosirProductQuick = data['priceGrosirProductQuick'];

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
    };
  }
}
