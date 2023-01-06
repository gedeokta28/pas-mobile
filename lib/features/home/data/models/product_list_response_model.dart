// To parse this JSON data, do
//
//     final productListResponseModel = productListResponseModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ProductListResponseModel productListResponseModelFromJson(String str) =>
    ProductListResponseModel.fromJson(json.decode(str));

String productListResponseModelToJson(ProductListResponseModel data) =>
    json.encode(data.toJson());

class ProductListResponseModel {
  ProductListResponseModel({
    required this.data,
    required this.links,
    required this.meta,
    required this.status,
    required this.message,
  });

  List<Product> data;
  Links links;
  Meta meta;
  String status;
  String message;

  factory ProductListResponseModel.fromJson(Map<String, dynamic> json) =>
      ProductListResponseModel(
        data: List<Product>.from(json["data"].map((x) => Product.fromJson(x))),
        links: Links.fromJson(json["links"]),
        meta: Meta.fromJson(json["meta"]),
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "links": links.toJson(),
        "meta": meta.toJson(),
        "status": status,
        "message": message,
      };
}

class Product {
  Product({
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
  List<ImageProduct> images;
  BrandProduct brand;
  CategoryProduct category;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
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
        images: List<ImageProduct>.from(
            json["images"].map((x) => ImageProduct.fromJson(x))),
        brand: BrandProduct.fromJson(json["brand"]),
        category: CategoryProduct.fromJson(json["category"]),
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
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "brand": brand.toJson(),
        "category": category.toJson(),
      };
}

class BrandProduct {
  BrandProduct({
    required this.brandid,
    required this.brandname,
    required this.brandimage,
  });

  String brandid;
  String brandname;
  dynamic brandimage;

  factory BrandProduct.fromJson(Map<String, dynamic> json) => BrandProduct(
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

class CategoryProduct {
  CategoryProduct({
    required this.categoryid,
    required this.categoryname,
    required this.categoryimage,
  });

  String categoryid;
  String categoryname;
  dynamic categoryimage;

  factory CategoryProduct.fromJson(Map<String, dynamic> json) =>
      CategoryProduct(
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

class Links {
  Links({
    required this.first,
    required this.last,
    required this.prev,
    required this.next,
  });

  String first;
  String last;
  dynamic prev;
  String next;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        first: json["first"],
        last: json["last"],
        prev: json["prev"],
        next: json["next"],
      );

  Map<String, dynamic> toJson() => {
        "first": first,
        "last": last,
        "prev": prev,
        "next": next,
      };
}

class Meta {
  Meta({
    required this.currentPage,
    required this.from,
    required this.lastPage,
    required this.links,
    required this.path,
    required this.perPage,
    required this.to,
    required this.total,
  });

  int currentPage;
  int from;
  int lastPage;
  List<Link> links;
  String path;
  int perPage;
  int to;
  int total;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        currentPage: json["current_page"],
        from: json["from"],
        lastPage: json["last_page"],
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        path: json["path"],
        perPage: json["per_page"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "from": from,
        "last_page": lastPage,
        "links": List<dynamic>.from(links.map((x) => x.toJson())),
        "path": path,
        "per_page": perPage,
        "to": to,
        "total": total,
      };
}

class Link {
  Link({
    required this.url,
    required this.label,
    required this.active,
  });

  String? url;
  String label;
  bool active;

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"] ?? '',
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url ?? '',
        "label": label,
        "active": active,
      };
}

class ImageProduct {
  ImageProduct({
    required this.id,
    required this.url,
  });

  String id;
  String url;

  factory ImageProduct.fromJson(Map<String, dynamic> json) => ImageProduct(
        id: json["id"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
      };
}
