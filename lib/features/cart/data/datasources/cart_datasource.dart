import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pas_mobile/core/utility/extensions.dart';
import 'package:pas_mobile/core/utility/helper.dart';
import 'package:pas_mobile/features/cart/data/models/cart_list_model.dart';
import 'package:pas_mobile/features/cart/data/models/cart_response_model.dart';

abstract class CartDataSource {
  Future<CartResponseModel> addToCart(FormData formData);
  Future<List<ItemCart>> getCart();
}

class CartDataSourceImpl implements CartDataSource {
  final Dio dio;

  CartDataSourceImpl({required this.dio});
  @override
  Future<CartResponseModel> addToCart(FormData formData) async {
    String path = 'api/carts';
    dio.withToken();

    try {
      final response = await dio.post(
        path,
        data: formData,
      );
      final model = CartResponseModel.fromJson(response.data);
      return model;
    } catch (e) {
      logMe(e);
      rethrow;
    }
  }

  @override
  Future<List<ItemCart>> getCart() async {
    String path = 'api/carts';
    dio.withToken();

    try {
      final response = await dio.get(
        path,
      );
      final model = CartListResponseModel.fromJson(response.data);
      return model.data;
    } catch (e) {
      logMe(e);
      rethrow;
    }
  }
}
