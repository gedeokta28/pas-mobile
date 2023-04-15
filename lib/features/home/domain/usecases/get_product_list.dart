import 'package:dartz/dartz.dart';
import 'package:pas_mobile/features/home/data/models/product_list_response_model.dart';
import 'package:pas_mobile/features/home/domain/repositories/product_repository.dart';

import '../../../../core/error/failures.dart';

abstract class GetProductListUseCase<Type> {
  Future<Either<Failure, ProductListResponseModel>> call();
}

class GetProductList implements GetProductListUseCase<String> {
  final ProductRepsitory repository;

  GetProductList({required this.repository});

  @override
  Future<Either<Failure, ProductListResponseModel>> call() async {
    final result = await repository.getProductList();
    return result.fold((l) => Left(l), (r) {
      return Right(r);
    });
  }
}
