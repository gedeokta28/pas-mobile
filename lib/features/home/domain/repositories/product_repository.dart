import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pas_mobile/features/home/data/models/product_list_response_model.dart';

import '../../../../core/error/failures.dart';

abstract class ProductRepsitory {
  Future<Either<Failure, ProductListResponseModel>> getProductList();
}
