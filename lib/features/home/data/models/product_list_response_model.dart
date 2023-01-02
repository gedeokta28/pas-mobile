// To parse this JSON data, do
//
//     final productListResponseModel = productListResponseModelFromJson(jsonString);

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
    required this.brand,
    required this.brandname,
    required this.categoryid,
    required this.categoryname,
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
    required this.images,
  });

  String stockid;
  String stockname;
  String barcode;
  String brand;
  String brandname;
  String categoryid;
  String categoryname;
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
  String? photourl;
  List<ImageProduct> images;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        stockid: json["stockid"],
        stockname: json["stockname"],
        barcode: json["barcode"],
        brand: json["brand"],
        brandname: json["brandname"],
        categoryid: json["categoryid"],
        categoryname: json["categoryname"],
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
        photourl: json["photourl"] ?? '',
        images: List<ImageProduct>.from(
            json["images"].map((x) => ImageProduct.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "stockid": stockid,
        "stockname": stockname,
        "barcode": barcode,
        "brand": brand,
        "brandname": brandname,
        "categoryid": categoryid,
        "categoryname": categoryname,
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
        "photourl": photourl ?? '',
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
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
