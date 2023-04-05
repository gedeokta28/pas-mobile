import 'package:dartz/dartz.dart';
import 'package:pas_mobile/features/order/data/models/create_order_response_model.dart';
import 'package:pas_mobile/features/order/data/models/order_list_model.dart';

import '../../../../core/error/failures.dart';

abstract class OrderRepository {
  Future<Either<Failure, String>> createOrder(dynamic jsonData);
  Future<Either<Failure, DetailOrder>> detailOrder(String orderId);
  Future<Either<Failure, List<OrderDataList>>> listOrder();
}
