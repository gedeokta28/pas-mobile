import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pas_mobile/core/utility/extensions.dart';

import '../../../../core/utility/helper.dart';
import '../models/login_data_model.dart';

abstract class LoginDataSource {
  Future<bool> updateDeviceToken(String token);
  Future<LoginDataModel> doLogin(FormData data);
}

class LoginDataSourceImplementation implements LoginDataSource {
  final Dio dio;

  LoginDataSourceImplementation({required this.dio});

  @override
  Future<LoginDataModel> doLogin(FormData data) async {
    String url = 'api/login';

    try {
      final response = await dio.post(
        url,
        data: data,
        options: options(headers: null),
      );
      final model = LoginResponseModel.fromJson(response.data);
      return model.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> updateDeviceToken(String token) async {
    const path = 'api/fcm_token';
    final data = {
      'fcm_token': token,
    };
    try {
      dio.withToken();
      final response = await dio.put(path, data: data);
      return response.statusCode == HttpStatus.ok;
    } catch (e) {
      rethrow;
    }
  }
}
