// To parse this JSON data, do
//
//     final orderNotifResponseModel = orderNotifResponseModelFromJson(jsonString);

import 'dart:convert';

OrderNotifResponseModel orderNotifResponseModelFromJson(String str) =>
    OrderNotifResponseModel.fromJson(json.decode(str));

String orderNotifResponseModelToJson(OrderNotifResponseModel data) =>
    json.encode(data.toJson());

class OrderNotifResponseModel {
  final List<OrderNotif> data;
  final String status;
  final String message;

  OrderNotifResponseModel({
    required this.data,
    required this.status,
    required this.message,
  });

  factory OrderNotifResponseModel.fromJson(Map<String, dynamic> json) =>
      OrderNotifResponseModel(
        data: List<OrderNotif>.from(
            json["data"].map((x) => OrderNotif.fromJson(x))),
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "status": status,
        "message": message,
      };
}

class OrderNotif {
  final String id;
  final OrderNotifItem data;
  final dynamic readAt;
  final DateTime createdAt;

  OrderNotif({
    required this.id,
    required this.data,
    required this.readAt,
    required this.createdAt,
  });

  factory OrderNotif.fromJson(Map<String, dynamic> json) => OrderNotif(
        id: json["id"],
        data: OrderNotifItem.fromJson(json["data"]),
        readAt: json["read_at"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "data": data.toJson(),
        "read_at": readAt,
        "created_at": createdAt.toIso8601String(),
      };
}

class OrderNotifItem {
  final String orderId;
  final String orderStatus;
  final String message;

  OrderNotifItem({
    required this.orderId,
    required this.orderStatus,
    required this.message,
  });

  factory OrderNotifItem.fromJson(Map<String, dynamic> json) => OrderNotifItem(
        orderId: json["order_id"],
        orderStatus: json["order_status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "order_status": orderStatus,
        "message": message,
      };
}
