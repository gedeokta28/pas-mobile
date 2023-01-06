import 'package:dartz/dartz.dart';
import 'package:pas_mobile/features/home/domain/repositories/product_repository.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/detail_product_model.dart';

abstract class GetProductDetailUseCase<Type> {
  Future<Either<Failure, ProductDetail>> call(String productId);
}

class GetProductDetail implements GetProductDetailUseCase<String> {
  final ProductRepsitory repository;

  GetProductDetail({required this.repository});

  @override
  Future<Either<Failure, ProductDetail>> call(String productId) async {
    final result = await repository.getProductDetail(productId);
    return result.fold((l) => Left(l), (r) {
      return Right(r);
    });
  }
}
