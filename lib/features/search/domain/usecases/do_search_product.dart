import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pas_mobile/features/search/data/models/search_product_response_model.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utility/session_helper.dart';
import '../repositories/search_product_repositories.dart';

abstract class SearchProductUseCase<Type> {
  Future<Either<Failure, List<ProductSearch>>> call(String keyword);
}

class DoSearchProduct implements SearchProductUseCase<String> {
  final SearchProductRepository repository;

  DoSearchProduct({required this.repository});

  @override
  Future<Either<Failure, List<ProductSearch>>> call(String keyword) async {
    final result = await repository.doSearchProduct(keyword);
    return result.fold((l) => Left(l), (r) {
      return Right(r);
    });
  }
}
