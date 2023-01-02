// To parse this JSON data, do
//
//     final categoryListResponseModel = categoryListResponseModelFromJson(jsonString);

import 'dart:convert';

CategoryListResponseModel categoryListResponseModelFromJson(String str) =>
    CategoryListResponseModel.fromJson(json.decode(str));

String categoryListResponseModelToJson(CategoryListResponseModel data) =>
    json.encode(data.toJson());

class CategoryListResponseModel {
  CategoryListResponseModel({
    required this.data,
    required this.status,
    required this.message,
  });

  List<Category> data;
  String status;
  String message;

  factory CategoryListResponseModel.fromJson(Map<String, dynamic> json) =>
      CategoryListResponseModel(
        data:
            List<Category>.from(json["data"].map((x) => Category.fromJson(x))),
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "status": status,
        "message": message,
      };
}

class Category {
  Category({
    required this.categoryid,
    required this.categoryname,
    required this.photo,
  });

  String categoryid;
  String categoryname;
  dynamic photo;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        categoryid: json["categoryid"],
        categoryname: json["categoryname"],
        photo: json["photo"],
      );

  Map<String, dynamic> toJson() => {
        "categoryid": categoryid,
        "categoryname": categoryname,
        "photo": photo,
      };
}
