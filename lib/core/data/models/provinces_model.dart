// To parse this JSON data, do
//
//     final provincesModel = provincesModelFromJson(jsonString);

import 'dart:convert';

ProvincesModel provincesModelFromJson(String str) => ProvincesModel.fromJson(json.decode(str));

String provincesModelToJson(ProvincesModel data) => json.encode(data.toJson());

class ProvincesModel {
    ProvincesModel({
        required this.status,
        required this.data,
    });

    String status;
    List<Province> data;

    factory ProvincesModel.fromJson(Map<String, dynamic> json) => ProvincesModel(
        status: json["status"],
        data: List<Province>.from(json["data"].map((x) => Province.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Province {
    Province({
        required this.id,
        required this.name,
    });

    String id;
    String name;

    factory Province.fromJson(Map<String, dynamic> json) => Province(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
