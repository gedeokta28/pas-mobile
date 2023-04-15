import 'package:dartz/dartz.dart';
import 'package:pas_mobile/features/home/domain/repositories/product_repository.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/variant_product_response_model.dart';

abstract class GetProductVariantUseCase<Type> {
  Future<Either<Failure, VariantList>> call(String productId);
}

class GetProductVariant implements GetProductVariantUseCase<String> {
  final ProductRepsitory repository;

  GetProductVariant({required this.repository});

  @override
  Future<Either<Failure, VariantList>> call(String productId) async {
    final result = await repository.getProductVariant(productId);
    return result.fold((l) => Left(l), (r) {
      return Right(r);
    });
  }
}
