// To parse this JSON data, do
//
//     final infoResponseModel = infoResponseModelFromJson(jsonString);

import 'dart:convert';

InfoResponseModel infoResponseModelFromJson(String str) =>
    InfoResponseModel.fromJson(json.decode(str));

String infoResponseModelToJson(InfoResponseModel data) =>
    json.encode(data.toJson());

class InfoResponseModel {
  final String status;
  final String message;
  final InfoData data;

  InfoResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory InfoResponseModel.fromJson(Map<String, dynamic> json) =>
      InfoResponseModel(
        status: json["status"],
        message: json["message"],
        data: InfoData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class InfoData {
  final String uuid;
  final String key;
  final String value;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic deletedAt;

  InfoData({
    required this.uuid,
    required this.key,
    required this.value,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory InfoData.fromJson(Map<String, dynamic> json) => InfoData(
        uuid: json["uuid"],
        key: json["key"],
        value: json["value"] ?? '',
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "key": key,
        "value": value,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
      };
}
