import 'dart:convert';

CreateAddressResponseModel createAddressResponseModelFromJson(String str) =>
    CreateAddressResponseModel.fromJson(json.decode(str));

String createAddressResponseModelToJson(CreateAddressResponseModel data) =>
    json.encode(data.toJson());

class CreateAddressResponseModel {
  CreateAddressResponseModel({
    required this.status,
  });

  String status;

  factory CreateAddressResponseModel.fromJson(Map<String, dynamic> json) =>
      CreateAddressResponseModel(
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
      };
}
