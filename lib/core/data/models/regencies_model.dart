// To parse this JSON data, do
//
//     final regenciesModel = regenciesModelFromJson(jsonString);

import 'dart:convert';

List<RegenciesModel> regenciesModelFromJson(String str) =>
    List<RegenciesModel>.from(
        json.decode(str).map((x) => RegenciesModel.fromJson(x)));

String regenciesModelToJson(List<RegenciesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RegenciesModel {
  RegenciesModel({
    required this.id,
    required this.provinceId,
    required this.name,
  });

  String id;
  String provinceId;
  String name;

  factory RegenciesModel.fromJson(Map<String, dynamic> json) => RegenciesModel(
        id: json["id"],
        provinceId: json["province_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "province_id": provinceId,
        "name": name,
      };
}
