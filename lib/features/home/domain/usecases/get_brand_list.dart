import 'package:dartz/dartz.dart';
import 'package:pas_mobile/features/home/data/models/brand_list_response_model.dart';
import 'package:pas_mobile/features/home/domain/repositories/product_repository.dart';

import '../../../../core/error/failures.dart';

abstract class GetBrandListUseCase<Type> {
  Future<Either<Failure, List<BrandList>>> call();
}

class GetBrandList implements GetBrandListUseCase<String> {
  final ProductRepsitory repository;

  GetBrandList({required this.repository});

  @override
  Future<Either<Failure, List<BrandList>>> call() async {
    final result = await repository.getBrandList();
    return result.fold((l) => Left(l), (r) {
      return Right(r);
    });
  }
}
