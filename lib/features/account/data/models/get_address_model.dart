// To parse this JSON data, do
//
//     final getAddressResponseModel = getAddressResponseModelFromJson(jsonString);

import 'dart:convert';

GetAddressResponseModel getAddressResponseModelFromJson(String str) =>
    GetAddressResponseModel.fromJson(json.decode(str));

String getAddressResponseModelToJson(GetAddressResponseModel data) =>
    json.encode(data.toJson());

class GetAddressResponseModel {
  GetAddressResponseModel({
    required this.status,
    required this.data,
  });

  String status;
  List<ShippingAddress> data;

  factory GetAddressResponseModel.fromJson(Map<String, dynamic> json) =>
      GetAddressResponseModel(
        status: json["status"],
        data: List<ShippingAddress>.from(
            json["data"].map((x) => ShippingAddress.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class ShippingAddress {
  ShippingAddress({
    required this.id,
    required this.customerid,
    required this.fullname,
    required this.phone,
    required this.province,
    required this.city,
    required this.streetAddress,
    required this.addressDetail,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  String id;
  String customerid;
  String fullname;
  String phone;
  String province;
  String city;
  String streetAddress;
  String addressDetail;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;

  factory ShippingAddress.fromJson(Map<String, dynamic> json) =>
      ShippingAddress(
        id: json["id"],
        customerid: json["customerid"],
        fullname: json["fullname"],
        phone: json["phone"],
        province: json["province"],
        city: json["city"],
        streetAddress: json["street_address"],
        addressDetail: json["address_detail"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customerid": customerid,
        "fullname": fullname,
        "phone": phone,
        "province": province,
        "city": city,
        "street_address": streetAddress,
        "address_detail": addressDetail,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
      };
}
