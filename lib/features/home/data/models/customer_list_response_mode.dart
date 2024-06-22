import 'dart:convert';

class CustomerListResponseModel {
  final String status;
  final String message;
  final List<CustomerData> data;

  CustomerListResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CustomerListResponseModel.fromRawJson(String str) =>
      CustomerListResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CustomerListResponseModel.fromJson(Map<String, dynamic> json) =>
      CustomerListResponseModel(
        status: json["status"],
        message: json["message"],
        data: List<CustomerData>.from(
            json["data"].map((x) => CustomerData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class CustomerData {
  final String customerid;
  final String customername;
  final String email;

  CustomerData({
    required this.customerid,
    required this.customername,
    required this.email,
  });

  factory CustomerData.fromRawJson(String str) =>
      CustomerData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CustomerData.fromJson(Map<String, dynamic> json) => CustomerData(
        customerid: json["customerid"],
        customername: json["customername"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "customerid": customerid,
        "customername": customername,
        "email": email,
      };
}
