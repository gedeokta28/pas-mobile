import 'package:dartz/dartz.dart';
import 'package:pas_mobile/features/home/data/models/product_list_response_model.dart';
import 'package:pas_mobile/features/home/domain/repositories/product_repository.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/category_list_response_model.dart';

abstract class GetCategoryListUseCase<Type> {
  Future<Either<Failure, CategoryListResponseModel>> call();
}

class GetCategoryList implements GetCategoryListUseCase<String> {
  final ProductRepsitory repository;

  GetCategoryList({required this.repository});

  @override
  Future<Either<Failure, CategoryListResponseModel>> call() async {
    final result = await repository.getCategoryList();
    return result.fold((l) => Left(l), (r) {
      return Right(r);
    });
  }
}
