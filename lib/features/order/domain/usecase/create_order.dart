import 'package:dartz/dartz.dart';
import 'package:pas_mobile/features/order/domain/repositories/order_repository.dart';

import '../../../../core/error/failures.dart';

abstract class CreateOrderUseCase<Type> {
  Future<Either<Failure, String>> execute(dynamic jsonData);
}

class DoCreateOrder implements CreateOrderUseCase<String> {
  final OrderRepository repository;

  DoCreateOrder({required this.repository});

  @override
  Future<Either<Failure, String>> execute(dynamic jsonData) async {
    final result = await repository.createOrder(jsonData);
    return result.fold((l) => Left(l), (r) {
      return Right(r);
    });
  }
}
