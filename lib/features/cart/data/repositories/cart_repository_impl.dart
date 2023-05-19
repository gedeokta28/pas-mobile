import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pas_mobile/features/cart/data/models/cart_response_model.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/utility/helper.dart';
import '../../domain/repositories/cart_repository.dart';
import '../datasources/cart_datasource.dart';
import '../models/cart_list_model.dart';

class CartRepositoryImpl implements CartRepository {
  final CartDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  CartRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, CartResponseModel>> addToCart(
      FormData formData) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.addToCart(formData);
        return Right(result);
      } on DioError catch (e) {
        logMe(e);
        return const Left(ServerFailure());
      }
    } else {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, CartResponseModel>> addToCartQuickOrder(
      dynamic productList) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.addToCartQuickOrder(productList);
        return Right(result);
      } on DioError catch (e) {
        logMe(e);
        return const Left(ServerFailure());
      }
    } else {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<ItemCart>>> getCart() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getCart();
        return Right(result);
      } on DioError catch (e) {
        logMe(e);
        return const Left(ServerFailure());
      }
    } else {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, CartResponseModel>> updateCart(
      Map<String, String> data, String cartId) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.updateCart(data, cartId);
        return Right(result);
      } on DioError catch (e) {
        logMe(e);
        return const Left(ServerFailure());
      }
    } else {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, CartResponseModel>> deleteCart(String cartId) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.deleteCart(cartId);
        return Right(result);
      } on DioError catch (e) {
        logMe(e);
        return const Left(ServerFailure());
      }
    } else {
      return const Left(ServerFailure());
    }
  }
}
