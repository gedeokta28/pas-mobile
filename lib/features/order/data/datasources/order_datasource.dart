import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pas_mobile/core/utility/extensions.dart';
import 'package:pas_mobile/core/utility/helper.dart';
import 'package:pas_mobile/features/order/data/models/order_list_model.dart';

import '../models/create_order_response_model.dart';

abstract class OrderDataSource {
  Future<String> createOrder(dynamic jsonData);
  Future<DetailOrder> detailOrder(String orderId);
  Future<List<OrderDataList>> listOrder();
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

  @override
  Future<DetailOrder> detailOrder(String orderId) async {
    String path = 'api/orders/$orderId';
    dio.withToken();

    try {
      final response = await dio.get(
        path,
      );
      final model = CreateOrderResponseModel.fromJson(response.data);
      return model.data;
    } catch (e) {
      logMe(e);
      rethrow;
    }
  }

  @override
  Future<List<OrderDataList>> listOrder() async {
    String path = 'api/orders?orderby=salesorderno&direction=desc';
    dio.withToken();

    try {
      final response = await dio.get(
        path,
      );
      final model = OrderListModel.fromJson(response.data);
      return model.data;
    } catch (e) {
      logMe(e);
      rethrow;
    }
  }
}
