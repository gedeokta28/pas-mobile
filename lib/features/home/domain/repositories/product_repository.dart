import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pas_mobile/features/home/data/models/brand_list_response_model.dart';
import 'package:pas_mobile/features/home/data/models/detail_product_model.dart';
import 'package:pas_mobile/features/home/data/models/product_list_response_model.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/category_list_response_model.dart';
import '../../data/models/variant_product_response_model.dart';

abstract class ProductRepsitory {
  Future<Either<Failure, ProductListResponseModel>> getProductList();
  Future<Either<Failure, CategoryListResponseModel>> getCategoryList();
  Future<Either<Failure, List<BrandList>>> getBrandList();
  Future<Either<Failure, ProductDetail>> getProductDetail(String productId);
  Future<Either<Failure, VariantList>> getProductVariant(String productId);
}
