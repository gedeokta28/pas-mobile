// To parse this JSON data, do
//
//     final activityNotifResponseModel = activityNotifResponseModelFromJson(jsonString);

import 'dart:convert';

ActivityNotifResponseModel activityNotifResponseModelFromJson(String str) =>
    ActivityNotifResponseModel.fromJson(json.decode(str));

String activityNotifResponseModelToJson(ActivityNotifResponseModel data) =>
    json.encode(data.toJson());

class ActivityNotifResponseModel {
  final List<ActivityNotif> data;
  final String status;
  final String message;

  ActivityNotifResponseModel({
    required this.data,
    required this.status,
    required this.message,
  });

  factory ActivityNotifResponseModel.fromJson(Map<String, dynamic> json) =>
      ActivityNotifResponseModel(
        data: List<ActivityNotif>.from(
            json["data"].map((x) => ActivityNotif.fromJson(x))),
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "status": status,
        "message": message,
      };
}

class ActivityNotif {
  final String id;
  final String image;
  final String description;

  ActivityNotif({
    required this.id,
    required this.image,
    required this.description,
  });

  factory ActivityNotif.fromJson(Map<String, dynamic> json) => ActivityNotif(
        id: json["id"],
        image: json["image"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "description": description,
      };
}
