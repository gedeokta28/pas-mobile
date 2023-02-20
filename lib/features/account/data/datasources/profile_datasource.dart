import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pas_mobile/core/utility/extensions.dart';
import 'package:pas_mobile/features/account/data/models/update_profile_response_model.dart';

import '../../../../core/error/exception.dart';
import '../models/profile_model.dart';

abstract class ProfileDataSource {
  Future<Profile> getProfile();
  Future<UpdateProfileResponse> doUpdateProfile(Map<String, String> data);
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
}
