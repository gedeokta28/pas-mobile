import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pas_mobile/features/cart/data/models/cart_response_model.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/cart_list_model.dart';

abstract class CartRepository {
  Future<Either<Failure, CartResponseModel>> addToCart(FormData formData);
  Future<Either<Failure, CartResponseModel>> updateCart(
      Map<String, String> data, String cartId);
  Future<Either<Failure, CartResponseModel>> deleteCart(String cartId);
  Future<Either<Failure, List<ItemCart>>> getCart();
}
