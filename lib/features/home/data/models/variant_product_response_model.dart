// To parse this JSON data, do
//
//     final variantProductModel = variantProductModelFromJson(jsonString);

import 'dart:convert';

VariantProductModel variantProductModelFromJson(String str) =>
    VariantProductModel.fromJson(json.decode(str));

String variantProductModelToJson(VariantProductModel data) =>
    json.encode(data.toJson());

class VariantProductModel {
  VariantProductModel({
    required this.data,
    required this.status,
    required this.message,
  });

  final VariantList data;
  final String status;
  final String message;

  factory VariantProductModel.fromJson(Map<String, dynamic> json) =>
      VariantProductModel(
        data: VariantList.fromJson(json["data"]),
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "status": status,
        "message": message,
      };
}

class VariantList {
  VariantList({
    required this.size,
    required this.color,
  });

  final List<ProductVariant> size;
  final List<ProductVariant> color;

  factory VariantList.fromJson(Map<String, dynamic> json) => VariantList(
        size: List<ProductVariant>.from(
            json["size"].map((x) => ProductVariant.fromJson(x))),
        color: List<ProductVariant>.from(
            json["color"].map((x) => ProductVariant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "size": List<dynamic>.from(size.map((x) => x.toJson())),
        "color": List<dynamic>.from(color.map((x) => x.toJson())),
      };
}

class ProductVariant {
  ProductVariant({
    required this.stockid,
    required this.stockname,
    required this.barcode,
    required this.brandid,
    required this.categoryid,
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
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.stockdescription,
    required this.variantStockid,
    required this.variantOptionid,
    required this.variantOption,
  });

  final String stockid;
  final String stockname;
  final String barcode;
  final String brandid;
  final String categoryid;
  final String hrg1;
  final String disclist1;
  final String hrg2;
  final String disclist2;
  final String hrg3;
  final String disclist3;
  final String qty1;
  final String unit1;
  final String qty2;
  final String unit2;
  final String qty3;
  final String unit3;
  final String berat;
  final String discountinued;
  final dynamic photourl;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic deletedAt;
  final String stockdescription;
  final String variantStockid;
  final String variantOptionid;
  final VariantOption variantOption;

  factory ProductVariant.fromJson(Map<String, dynamic> json) => ProductVariant(
        stockid: json["stockid"],
        stockname: json["stockname"],
        barcode: json["barcode"],
        brandid: json["brandid"],
        categoryid: json["categoryid"],
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
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        stockdescription: json["stockdescription"],
        variantStockid: json["variant_stockid"],
        variantOptionid: json["variant_optionid"],
        variantOption: VariantOption.fromJson(json["variant_option"]),
      );

  Map<String, dynamic> toJson() => {
        "stockid": stockid,
        "stockname": stockname,
        "barcode": barcode,
        "brandid": brandid,
        "categoryid": categoryid,
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
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "stockdescription": stockdescription,
        "variant_stockid": variantStockid,
        "variant_optionid": variantOptionid,
        "variant_option": variantOption.toJson(),
      };
}

class VariantOption {
  VariantOption({
    required this.optionid,
    required this.name,
  });

  final String optionid;
  final String name;

  factory VariantOption.fromJson(Map<String, dynamic> json) => VariantOption(
        optionid: json["optionid"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "optionid": optionid,
        "name": name,
      };
}
