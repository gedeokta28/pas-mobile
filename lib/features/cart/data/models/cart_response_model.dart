// To parse this JSON data, do
//
//     final cartResponseModel = cartResponseModelFromJson(jsonString);

import 'dart:convert';

CartResponseModel cartResponseModelFromJson(String str) =>
    CartResponseModel.fromJson(json.decode(str));

String cartResponseModelToJson(CartResponseModel data) =>
    json.encode(data.toJson());

class CartResponseModel {
  CartResponseModel({
    required this.status,
    required this.message,
  });

  String status;
  String message;

  factory CartResponseModel.fromJson(Map<String, dynamic> json) =>
      CartResponseModel(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
