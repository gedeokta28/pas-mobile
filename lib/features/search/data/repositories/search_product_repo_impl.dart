import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pas_mobile/core/utility/helper.dart';
import 'package:pas_mobile/features/search/data/models/search_product_response_model.dart';

import '../../../../core/error/failures.dart';
import '../../domain/repositories/search_product_repositories.dart';
import '../search_product_datasource.dart';

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
}
