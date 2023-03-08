import 'package:flutter/material.dart';

class CartListUpdated {
  late final String? id;
  late final int? quantity;

  CartListUpdated({
    required this.id,
    required this.quantity,
  });

  CartListUpdated.fromMap(Map<dynamic, dynamic> data)
      : id = data['id'],
        quantity = data['quantity'];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'quantity': quantity,
    };
  }
}
