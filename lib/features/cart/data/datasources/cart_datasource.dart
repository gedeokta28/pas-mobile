
import 'package:dio/dio.dart';
import 'package:pas_mobile/core/utility/extensions.dart';
import 'package:pas_mobile/core/utility/helper.dart';
import 'package:pas_mobile/features/cart/data/models/cart_list_model.dart';
import 'package:pas_mobile/features/cart/data/models/cart_response_model.dart';

abstract class CartDataSource {
  Future<CartResponseModel> addToCart(FormData formData);
  Future<CartResponseModel> addToCartQuickOrder(dynamic productList);
  Future<CartResponseModel> updateCart(Map<String, String> data, String cartId);
  Future<CartResponseModel> deleteCart(String cartId);
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
  Future<CartResponseModel> addToCartQuickOrder(dynamic productList) async {
    String path = 'api/carts';
    dio.withToken();

    try {
      final response = await dio.post(
        path,
        data: productList,
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

  @override
  Future<CartResponseModel> updateCart(
      Map<String, String> data, String cartId) async {
    String path = 'api/carts/$cartId';
    dio.withToken();

    try {
      final response = await dio.put(
        path,
        data: data,
      );
      final model = CartResponseModel.fromJson(response.data);
      return model;
    } catch (e) {
      logMe(e);
      rethrow;
    }
  }

  @override
  Future<CartResponseModel> deleteCart(String cartId) async {
    String path = 'api/carts/$cartId';
    dio.withToken();

    try {
      final response = await dio.delete(
        path,
      );
      final model = CartResponseModel.fromJson(response.data);
      return model;
    } catch (e) {
      logMe(e);
      rethrow;
    }
  }
}
