// To parse this JSON data, do
//
//     final detailProductModel = detailProductModelFromJson(jsonString);

import 'dart:convert';

DetailProductModel detailProductModelFromJson(String str) =>
    DetailProductModel.fromJson(json.decode(str));

String detailProductModelToJson(DetailProductModel data) =>
    json.encode(data.toJson());

class DetailProductModel {
  DetailProductModel({
    required this.data,
    required this.status,
    required this.message,
  });

  ProductDetail data;
  String status;
  String message;

  factory DetailProductModel.fromJson(Map<String, dynamic> json) =>
      DetailProductModel(
        data: ProductDetail.fromJson(json["data"]),
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "status": status,
        "message": message,
      };
}

class ProductDetail {
  ProductDetail({
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
    required this.imagesProductDetail,
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
  String stockdescription;
  List<ImageProductDetail> imagesProductDetail;
  Brand brand;
  Category category;

  factory ProductDetail.fromJson(Map<String, dynamic> json) => ProductDetail(
        stockid: json["stockid"],
        stockname: json["stockname"],
        barcode: json["barcode"],
        hrg1: json["hrg1"],
        disclist1: json["disclist1"],
        hrg2: json["hrg2"],
        disclist2: json["disclist2"],
        hrg3: json["hrg3"],
        disclist3: json["disclist3"],
        qty1: json["qty1"] == null
            ? '0'
            : json["qty1"] == '0.00'
                ? '0'
                : json["qty1"],
        unit1: json["unit1"] ?? 'pcs',
        qty2: json["qty2"] == null
            ? '0'
            : json["qty2"] == '0.00'
                ? '0'
                : json["qty2"],
        unit2: json["unit2"] ?? 'pcs',
        qty3: json["qty3"] == null
            ? '0'
            : json["qty3"] == '0.00'
                ? '0'
                : json["qty3"],
        unit3: json["unit3"] ?? 'pcs',
        berat: json["berat"],
        discountinued: json["discountinued"] ?? '',
        photourl: json["photourl"],
        stockdescription: json["stockdescription"] ?? '',
        imagesProductDetail: List<ImageProductDetail>.from(
            json["images"].map((x) => ImageProductDetail.fromJson(x))),
        brand: Brand.fromJson(json["brand"]),
        category: Category.fromJson(json["category"]),
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
        "photourl": photourl ?? '',
        "stockdescription": stockdescription,
        "images":
            List<dynamic>.from(imagesProductDetail.map((x) => x.toJson())),
        "brand": brand.toJson(),
        "category": category.toJson(),
      };
}

class Brand {
  Brand({
    required this.brandid,
    required this.brandname,
    required this.brandimage,
  });

  String brandid;
  String brandname;
  dynamic brandimage;

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
        brandid: json["brandid"],
        brandname: json["brandname"] ?? '-',
        brandimage: json["brandimage"],
      );

  Map<String, dynamic> toJson() => {
        "brandid": brandid,
        "brandname": brandname,
        "brandimage": brandimage,
      };
}

class Category {
  Category({
    required this.categoryid,
    required this.categoryname,
    required this.categoryimage,
  });

  String categoryid;
  String categoryname;
  dynamic categoryimage;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        categoryid: json["categoryid"],
        categoryname: json["categoryname"] ?? '',
        categoryimage: json["categoryimage"],
      );

  Map<String, dynamic> toJson() => {
        "categoryid": categoryid,
        "categoryname": categoryname,
        "categoryimage": categoryimage,
      };
}

class ImageProductDetail {
  ImageProductDetail({
    required this.id,
    required this.url,
  });

  String id;
  String url;

  factory ImageProductDetail.fromJson(Map<String, dynamic> json) =>
      ImageProductDetail(
        id: json["id"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
      };
}
