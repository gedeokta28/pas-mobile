// To parse this JSON data, do
//
//     final provincesModel = provincesModelFromJson(jsonString);

import 'dart:convert';

List<ProvincesModel> provincesModelFromJson(String str) =>
    List<ProvincesModel>.from(
        json.decode(str).map((x) => ProvincesModel.fromJson(x)));

String provincesModelToJson(List<ProvincesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProvincesModel {
  ProvincesModel({
    required this.id,
    required this.name,
  });

  String id;
  String name;

  factory ProvincesModel.fromJson(Map<String, dynamic> json) => ProvincesModel(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
