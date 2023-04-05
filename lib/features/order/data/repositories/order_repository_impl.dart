import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pas_mobile/features/order/data/datasources/order_datasource.dart';
import 'package:pas_mobile/features/order/data/models/create_order_response_model.dart';
import 'package:pas_mobile/features/order/domain/repositories/order_repository.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/utility/helper.dart';
import '../models/order_list_model.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderDataSource orderDataSource;
  final NetworkInfo networkInfo;

  OrderRepositoryImpl(
      {required this.orderDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, String>> createOrder(dynamic jsonData) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await orderDataSource.createOrder(jsonData);
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
  Future<Either<Failure, DetailOrder>> detailOrder(String orderId) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await orderDataSource.detailOrder(orderId);
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
  Future<Either<Failure, List<OrderDataList>>> listOrder() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await orderDataSource.listOrder();
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
