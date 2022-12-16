import 'package:dio/dio.dart';

import '../../../../core/utility/helper.dart';
import '../models/register_data_model.dart';

abstract class RegisterDataSource {
  Future<RegisterDataModel> doRegister(FormData data);
}

class RegisterDataSourceImplementation implements RegisterDataSource {
  final Dio dio;

  RegisterDataSourceImplementation({required this.dio});

  @override
  Future<RegisterDataModel> doRegister(FormData data) async {
    String url = 'api/register';

    try {
      final response = await dio.post(
        url,
        data: data,
        options: options(headers: null),
      );
      final model = RegisterResponseModel.fromJson(response.data);
      return model.data;
    } catch (e) {
      rethrow;
    }
  }
}
