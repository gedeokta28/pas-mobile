// To parse this JSON data, do
//
//     final brandListResponseModel = brandListResponseModelFromJson(jsonString);

import 'dart:convert';

BrandListListResponseModel brandListResponseModelFromJson(String str) =>
    BrandListListResponseModel.fromJson(json.decode(str));

String brandListResponseModelToJson(BrandListListResponseModel data) =>
    json.encode(data.toJson());

class BrandListListResponseModel {
  BrandListListResponseModel({
    required this.data,
    required this.status,
    required this.message,
  });

  List<BrandList> data;
  String status;
  String message;

  factory BrandListListResponseModel.fromJson(Map<String, dynamic> json) =>
      BrandListListResponseModel(
        data: List<BrandList>.from(
            json["data"].map((x) => BrandList.fromJson(x))),
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "status": status,
        "message": message,
      };
}

class BrandList {
  BrandList({
    required this.brandid,
    required this.brandname,
    required this.photo,
  });

  String brandid;
  String brandname;
  String photo;

  factory BrandList.fromJson(Map<String, dynamic> json) => BrandList(
        brandid: json["brandid"],
        brandname: json["brandname"] ?? '-',
        photo: json["photo"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "brandid": brandid,
        "brandname": brandname,
        "photo": photo,
      };
}
