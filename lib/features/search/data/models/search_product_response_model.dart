// To parse this JSON data, do
//
//     final searchProductModelResponse = searchProductModelResponseFromJson(jsonString);

import 'dart:convert';

SearchProductModelResponse searchProductModelResponseFromJson(String str) =>
    SearchProductModelResponse.fromJson(json.decode(str));

String searchProductModelResponseToJson(SearchProductModelResponse data) =>
    json.encode(data.toJson());

class SearchProductModelResponse {
  SearchProductModelResponse({
    required this.data,
    required this.status,
    required this.message,
  });

  List<ProductSearch> data;
  String status;
  String message;

  factory SearchProductModelResponse.fromJson(Map<String, dynamic> json) =>
      SearchProductModelResponse(
        data: List<ProductSearch>.from(
            json["data"].map((x) => ProductSearch.fromJson(x))),
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "status": status,
        "message": message,
      };
}

class ProductSearch {
  ProductSearch({
    required this.stockname,
  });

  String stockname;

  factory ProductSearch.fromJson(Map<String, dynamic> json) => ProductSearch(
        stockname: json["stockname"],
      );

  Map<String, dynamic> toJson() => {
        "stockname": stockname,
      };
}
