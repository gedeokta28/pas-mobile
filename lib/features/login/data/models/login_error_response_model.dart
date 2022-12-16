// To parse this JSON data, do
//
//     final loginErrorResponseModel = loginErrorResponseModelFromJson(jsonString);

import 'dart:convert';

LoginErrorResponseModel loginErrorResponseModelFromJson(String str) =>
    LoginErrorResponseModel.fromJson(json.decode(str));

String loginErrorResponseModelToJson(LoginErrorResponseModel data) =>
    json.encode(data.toJson());

class LoginErrorResponseModel {
  LoginErrorResponseModel({
    required this.status,
    required this.message,
  });

  String status;
  String message;

  factory LoginErrorResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginErrorResponseModel(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
