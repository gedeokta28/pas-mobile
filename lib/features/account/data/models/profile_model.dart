// To parse this JSON data, do
//
//     final provincesModel = provincesModelFromJson(jsonString);

import 'dart:convert';

ProfileModel provincesModelFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str));

String provincesModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  ProfileModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final String status;
  final String message;
  final Profile data;

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        status: json["status"],
        message: json["message"],
        data: Profile.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Profile {
  Profile({
    required this.customerid,
    required this.firstname,
    required this.lastname,
    required this.address,
    required this.province,
    required this.city,
    required this.postcode,
    required this.phone,
    required this.username,
    required this.email,
    required this.password,
    required this.registerdate,
    required this.contactperson,
    required this.npwp,
    required this.companyname,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  final String customerid;
  final dynamic firstname;
  final dynamic lastname;
  final dynamic address;
  final dynamic province;
  final dynamic city;
  final dynamic postcode;
  final dynamic phone;
  final String username;
  final String email;
  final String password;
  final DateTime registerdate;
  final dynamic contactperson;
  final String npwp;
  final dynamic companyname;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic deletedAt;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        customerid: json["customerid"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        address: json["address"],
        province: json["province"],
        city: json["city"],
        postcode: json["postcode"],
        phone: json["phone"],
        username: json["username"],
        email: json["email"],
        password: json["password"],
        registerdate: DateTime.parse(json["registerdate"]),
        contactperson: json["contactperson"],
        npwp: json["npwp"],
        companyname: json["companyname"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "customerid": customerid,
        "firstname": firstname,
        "lastname": lastname,
        "address": address,
        "province": province,
        "city": city,
        "postcode": postcode,
        "phone": phone,
        "username": username,
        "email": email,
        "password": password,
        "registerdate": registerdate.toIso8601String(),
        "contactperson": contactperson,
        "npwp": npwp,
        "companyname": companyname,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
      };
}
