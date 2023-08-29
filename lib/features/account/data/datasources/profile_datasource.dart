import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pas_mobile/core/utility/extensions.dart';
import 'package:pas_mobile/features/account/data/models/get_address_model.dart';
import 'package:pas_mobile/features/account/data/models/info_response_model.dart';
import 'package:pas_mobile/features/account/data/models/update_profile_response_model.dart';

import '../../../../core/error/exception.dart';
import '../models/create_address_response_model.dart';
import '../models/profile_model.dart';

abstract class ProfileDataSource {
  Future<Profile> getProfile();
  Future<InfoData> getInfo();
  Future<UpdateProfileResponse> doUpdateProfile(Map<String, String> data);
  Future<CreateAddressResponseModel> doUpdateAddress(
      Map<String, String> data, String addressId);
  Future<CreateAddressResponseModel> doCreateAddress(FormData formData);
  Future<CreateAddressResponseModel> doDeleteAddress(String addressId);
  Future<List<ShippingAddress>> getAddressList();
}

class ProfileDataSourceImpl implements ProfileDataSource {
  final Dio dio;

  ProfileDataSourceImpl({required this.dio});
  @override
  Future<Profile> getProfile() async {
    String path = 'api/me';
    dio.withToken();

    final response = await dio.get(path);

    if (response.statusCode == HttpStatus.ok) {
      final profileResponse = ProfileModel.fromJson(response.data);
      return profileResponse.data;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<InfoData> getInfo() async {
    String path = 'api/aboutus';
    dio.withToken();

    final response = await dio.get(path);

    if (response.statusCode == HttpStatus.ok) {
      final profileResponse = InfoResponseModel.fromJson(response.data);
      return profileResponse.data;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<UpdateProfileResponse> doUpdateProfile(
      Map<String, String> data) async {
    String url = 'api/me';

    dio.withToken();
    try {
      final response = await dio.patch(
        url,
        data: data,
      );
      final model = UpdateProfileResponse.fromJson(response.data);
      return model;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<CreateAddressResponseModel> doUpdateAddress(
      Map<String, String> data, String addressId) async {
    String url = 'api/me/address/$addressId';

    dio.withToken();
    try {
      final response = await dio.put(
        url,
        data: data,
      );
      final model = CreateAddressResponseModel.fromJson(response.data);
      return model;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<CreateAddressResponseModel> doCreateAddress(FormData formData) async {
    String url = 'api/me/address';

    dio.withToken();
    try {
      final response = await dio.post(
        url,
        data: formData,
      );
      final model = CreateAddressResponseModel.fromJson(response.data);
      return model;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<ShippingAddress>> getAddressList() async {
    String url = 'api/me/address';

    dio.withToken();
    try {
      final response = await dio.get(
        url,
      );
      final model = GetAddressResponseModel.fromJson(response.data);
      return model.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<CreateAddressResponseModel> doDeleteAddress(String addressId) async {
    String url = 'api/me/address/$addressId';

    dio.withToken();
    try {
      final response = await dio.delete(
        url,
      );
      final model = CreateAddressResponseModel.fromJson(response.data);
      return model;
    } catch (e) {
      rethrow;
    }
  }
}
