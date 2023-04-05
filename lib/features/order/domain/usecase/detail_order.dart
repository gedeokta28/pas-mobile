import 'package:dartz/dartz.dart';
import 'package:pas_mobile/features/order/data/models/create_order_response_model.dart';
import 'package:pas_mobile/features/order/domain/repositories/order_repository.dart';

import '../../../../core/error/failures.dart';

abstract class DetailOrderUseCase<Type> {
  Future<Either<Failure, DetailOrder>> execute(String orderId);
}

class GetDetailOrder implements DetailOrderUseCase<String> {
  final OrderRepository repository;

  GetDetailOrder({required this.repository});

  @override
  Future<Either<Failure, DetailOrder>> execute(String orderId) async {
    final result = await repository.detailOrder(orderId);
    return result.fold((l) => Left(l), (r) {
      return Right(r);
    });
  }
}
