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
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  List<Category> data;

  factory CategoryListResponseModel.fromJson(Map<String, dynamic> json) =>
      CategoryListResponseModel(
        status: json["status"],
        message: json["message"],
        data: List<Category>.from(json["data"].map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Category {
  Category({
    required this.id,
    required this.image,
    required this.name,
  });

  int id;
  String image;
  String name;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        image: json["image"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "name": name,
      };
}
