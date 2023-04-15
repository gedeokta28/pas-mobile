import 'package:dartz/dartz.dart';
import 'package:pas_mobile/features/order/data/models/order_list_model.dart';
import 'package:pas_mobile/features/order/domain/repositories/order_repository.dart';

import '../../../../core/error/failures.dart';

abstract class ListOrderUseCase<Type> {
  Future<Either<Failure, List<OrderDataList>>> execute();
}

class GetListOrder implements ListOrderUseCase<String> {
  final OrderRepository repository;

  GetListOrder({required this.repository});

  @override
  Future<Either<Failure, List<OrderDataList>>> execute() async {
    final result = await repository.listOrder();
    return result.fold((l) => Left(l), (r) {
      return Right(r);
    });
  }
}
