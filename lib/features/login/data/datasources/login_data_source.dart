import 'package:dio/dio.dart';

import '../../../../core/utility/helper.dart';
import '../models/login_data_model.dart';

abstract class LoginDataSource {
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
}
