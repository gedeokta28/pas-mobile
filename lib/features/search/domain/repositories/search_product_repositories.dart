import 'package:dartz/dartz.dart';
import 'package:pas_mobile/features/search/data/models/search_product_response_model.dart';

import '../../../../core/error/failures.dart';

abstract class SearchProductRepository {
  Future<Either<Failure, List<ProductSearch>>> doSearchProduct(String keyword);
}
