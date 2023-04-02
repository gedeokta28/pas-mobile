import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

abstract class OrderRepository {
  Future<Either<Failure, String>> createOrder(dynamic jsonData);
}
