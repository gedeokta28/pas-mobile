import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pas_mobile/core/utility/extensions.dart';
import 'package:pas_mobile/core/utility/helper.dart';

import '../models/create_order_response_model.dart';

abstract class OrderDataSource {
  Future<String> createOrder(dynamic jsonData);
}

class OrderDataSourceImpl implements OrderDataSource {
  final Dio dio;

  OrderDataSourceImpl({required this.dio});
  @override
  Future<String> createOrder(dynamic jsonData) async {
    String path = 'api/orders';
    dio.withToken();

    try {
      final response = await dio.post(
        path,
        data: jsonEncode(jsonData),
      );
      final model = CreateOrderResponseModel.fromJson(response.data);
      return model.data.salesorderno;
    } catch (e) {
      logMe(e);
      rethrow;
    }
  }
}
