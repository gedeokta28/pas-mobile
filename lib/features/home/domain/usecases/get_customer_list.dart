import 'package:dartz/dartz.dart';
import 'package:pas_mobile/features/home/data/models/customer_list_response_mode.dart';
import 'package:pas_mobile/features/home/domain/repositories/product_repository.dart';

import '../../../../core/error/failures.dart';

abstract class GetCustomerListUseCase<Type> {
  Future<Either<Failure, List<CustomerData>>> call(String params);
}

class GetCustomerList implements GetCustomerListUseCase<String> {
  final ProductRepsitory repository;

  GetCustomerList({required this.repository});

  @override
  Future<Either<Failure, List<CustomerData>>> call(String params) async {
    final result = await repository.getCustomerList(params);
    return result.fold((l) => Left(l), (r) {
      return Right(r);
    });
  }
}
