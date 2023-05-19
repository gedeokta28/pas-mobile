import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/product_list_response_model.dart';
import '../repositories/product_repository.dart';

abstract class GetProductListByUrlUseCase<Type> {
  Future<Either<Failure, ProductListResponseModel>> call(String url);
}

class GetProductListByUrl implements GetProductListByUrlUseCase<String> {
  final ProductRepsitory repository;

  GetProductListByUrl({required this.repository});

  @override
  Future<Either<Failure, ProductListResponseModel>> call(String url) async {
    final result = await repository.getProductListByUrl(url);
    return result.fold((l) => Left(l), (r) {
      return Right(r);
    });
  }
}
