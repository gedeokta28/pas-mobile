import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pas_mobile/features/home/data/models/product_list_response_model.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/category_list_response_model.dart';

abstract class ProductRepsitory {
  Future<Either<Failure, ProductListResponseModel>> getProductList();
  Future<Either<Failure, CategoryListResponseModel>> getCategoryList();
}
