import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pas_mobile/features/search/data/models/search_product_response_model.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utility/enum.dart';
import '../../../../core/utility/session_helper.dart';
import '../../data/models/filter_parameter.dart';
import '../../data/models/filter_product_model.dart';
import '../repositories/search_product_repositories.dart';

abstract class FilterProductUseCase<Type> {
  Future<Either<Failure, List<ProductFilter>>> call(
      TypeFilter typeFilter, FilterParameter filterParameter);
}

class DoFilterProduct implements FilterProductUseCase<String> {
  final SearchProductRepository repository;

  DoFilterProduct({required this.repository});

  @override
  Future<Either<Failure, List<ProductFilter>>> call(
      TypeFilter typeFilter, FilterParameter filterParameter) async {
    final result =
        await repository.doFilterProduct(typeFilter, filterParameter);
    return result.fold((l) => Left(l), (r) {
      return Right(r);
    });
  }
}