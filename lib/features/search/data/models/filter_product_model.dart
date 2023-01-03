// To parse this JSON data, do
//
//     final searchResultProductModel = searchResultProductModelFromJson(jsonString);

import 'dart:convert';

FilterProductProductModel searchResultProductModelFromJson(String str) =>
    FilterProductProductModel.fromJson(json.decode(str));

String searchResultProductModelToJson(FilterProductProductModel data) =>
    json.encode(data.toJson());

class FilterProductProductModel {
  FilterProductProductModel({
    required this.data,
    required this.status,
    required this.message,
  });

  List<ProductFilter> data;
  String status;
  String message;

  factory FilterProductProductModel.fromJson(Map<String, dynamic> json) =>
      FilterProductProductModel(
        data: List<ProductFilter>.from(
            json["data"].map((x) => ProductFilter.fromJson(x))),
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "status": status,
        "message": message,
      };
}

class ProductFilter {
  ProductFilter({
    required this.stockid,
    required this.stockname,
    required this.barcode,
    required this.hrg1,
    required this.disclist1,
    required this.hrg2,
    required this.disclist2,
    required this.hrg3,
    required this.disclist3,
    required this.qty1,
    required this.unit1,
    required this.qty2,
    required this.unit2,
    required this.qty3,
    required this.unit3,
    required this.berat,
    required this.discountinued,
    required this.photourl,
    required this.stockdescription,
    required this.images,
    required this.brand,
    required this.category,
  });

  String stockid;
  String stockname;
  String barcode;
  String hrg1;
  String disclist1;
  String hrg2;
  String disclist2;
  String hrg3;
  String disclist3;
  String qty1;
  String unit1;
  String qty2;
  String unit2;
  String qty3;
  String unit3;
  String berat;
  String discountinued;
  dynamic photourl;
  dynamic stockdescription;
  List<dynamic> images;
  BrandFilterProduct brand;
  CategoryFilterProduct category;

  factory ProductFilter.fromJson(Map<String, dynamic> json) =>
      ProductFilter(
        stockid: json["stockid"],
        stockname: json["stockname"],
        barcode: json["barcode"],
        hrg1: json["hrg1"],
        disclist1: json["disclist1"],
        hrg2: json["hrg2"],
        disclist2: json["disclist2"],
        hrg3: json["hrg3"],
        disclist3: json["disclist3"],
        qty1: json["qty1"],
        unit1: json["unit1"],
        qty2: json["qty2"],
        unit2: json["unit2"],
        qty3: json["qty3"],
        unit3: json["unit3"],
        berat: json["berat"],
        discountinued: json["discountinued"],
        photourl: json["photourl"],
        stockdescription: json["stockdescription"],
        images: List<dynamic>.from(json["images"].map((x) => x)),
        brand: BrandFilterProduct.fromJson(json["brand"]),
        category: CategoryFilterProduct.fromJson(json["category"]),
      );

  Map<String, dynamic> toJson() => {
        "stockid": stockid,
        "stockname": stockname,
        "barcode": barcode,
        "hrg1": hrg1,
        "disclist1": disclist1,
        "hrg2": hrg2,
        "disclist2": disclist2,
        "hrg3": hrg3,
        "disclist3": disclist3,
        "qty1": qty1,
        "unit1": unit1,
        "qty2": qty2,
        "unit2": unit2,
        "qty3": qty3,
        "unit3": unit3,
        "berat": berat,
        "discountinued": discountinued,
        "photourl": photourl,
        "stockdescription": stockdescription,
        "images": List<dynamic>.from(images.map((x) => x)),
        "brand": brand.toJson(),
        "category": category.toJson(),
      };
}

class BrandFilterProduct {
  BrandFilterProduct({
    required this.brandid,
    required this.brandname,
    required this.brandimage,
  });

  String brandid;
  String brandname;
  dynamic brandimage;

  factory BrandFilterProduct.fromJson(Map<String, dynamic> json) =>
      BrandFilterProduct(
        brandid: json["brandid"],
        brandname: json["brandname"],
        brandimage: json["brandimage"],
      );

  Map<String, dynamic> toJson() => {
        "brandid": brandid,
        "brandname": brandname,
        "brandimage": brandimage,
      };
}

class CategoryFilterProduct {
  CategoryFilterProduct({
    required this.categoryid,
    required this.categoryname,
    required this.categoryimage,
  });

  String categoryid;
  String categoryname;
  dynamic categoryimage;

  factory CategoryFilterProduct.fromJson(Map<String, dynamic> json) =>
      CategoryFilterProduct(
        categoryid: json["categoryid"],
        categoryname: json["categoryname"],
        categoryimage: json["categoryimage"],
      );

  Map<String, dynamic> toJson() => {
        "categoryid": categoryid,
        "categoryname": categoryname,
        "categoryimage": categoryimage,
      };
}
