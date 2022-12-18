import 'package:dio/dio.dart';

import '../../../../core/utility/helper.dart';
import '../models/forgot_password_model.dart';

abstract class ForgotPasswordDataSource {
  Future<ForgotPasswordResponseModel> doForgotPassword(FormData data);
}

class ForgotPasswordDataSourceImplementation
    implements ForgotPasswordDataSource {
  final Dio dio;

  ForgotPasswordDataSourceImplementation({required this.dio});

  @override
  Future<ForgotPasswordResponseModel> doForgotPassword(FormData data) async {
    String url = 'api/reset-password';

    try {
      final response = await dio.post(
        url,
        data: data,
        options: options(headers: null),
      );
      final model = ForgotPasswordResponseModel.fromJson(response.data);
      return model;
    } catch (e) {
      rethrow;
    }
  }
}
