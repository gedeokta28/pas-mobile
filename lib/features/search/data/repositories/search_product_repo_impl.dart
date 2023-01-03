import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pas_mobile/core/utility/helper.dart';
import 'package:pas_mobile/features/search/data/models/search_product_response_model.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utility/enum.dart';
import '../../domain/repositories/search_product_repositories.dart';
import '../datasources/search_product_datasource.dart';
import '../models/filter_parameter.dart';
import '../models/filter_product_model.dart';

class SearchProductRepoImpl implements SearchProductRepository {
  final SearchProductDataSource dataSource;

  SearchProductRepoImpl({required this.dataSource});

  @override
  Future<Either<Failure, List<ProductSearch>>> doSearchProduct(
      String keyword) async {
    try {
      final data = await dataSource.doSearchProduct(keyword);
      return Right(data);
    } on DioError catch (e) {
      logMe("Failure Search prod Repo ${e.error}");
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<ProductFilter>>> doFilterProduct(
      TypeFilter typeFilter, FilterParameter filterParameter) async {
    try {
      final data =
          await dataSource.doFilterProduct(typeFilter, filterParameter);
      return Right(data);
    } on DioError catch (e) {
      logMe("Failure Search filter prod Repo ${e.error}");
      return const Left(ServerFailure());
    }
  }
}
