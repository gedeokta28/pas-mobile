import 'package:dartz/dartz.dart';
import 'package:pas_mobile/features/search/data/models/search_product_response_model.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utility/enum.dart';
import '../../data/models/filter_parameter.dart';
import '../../data/models/filter_product_model.dart';

abstract class SearchProductRepository {
  Future<Either<Failure, List<ProductSearch>>> doSearchProduct(String keyword);
  Future<Either<Failure, List<ProductFilter>>> doFilterProduct(
      TypeFilter typeFilter, FilterParameter filterParameter);
}
