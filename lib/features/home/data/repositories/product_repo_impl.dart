import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pas_mobile/core/utility/helper.dart';
import 'package:pas_mobile/features/home/data/datasources/product_data_source.dart';
import 'package:pas_mobile/features/home/data/models/product_list_response_model.dart';
import 'package:pas_mobile/features/home/domain/repositories/product_repository.dart';

import '../../../../core/error/failures.dart';
import '../models/brand_list_response_model.dart';
import '../models/category_list_response_model.dart';
import '../models/detail_product_model.dart';
import '../models/variant_product_response_model.dart';

class ProductRepoImpl implements ProductRepsitory {
  final ProductDataSource dataSource;

  ProductRepoImpl({required this.dataSource});

  @override
  Future<Either<Failure, ProductListResponseModel>> getProductList(
      String? type) async {
    try {
      final data = await dataSource.getProductList(type);
      return Right(data);
    } on DioError catch (e) {
      logMe("Failure Login Repo ${e.error}");
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, ProductListResponseModel>> getProductListByUrl(
      String url) async {
    try {
      final data = await dataSource.getProductListByUrl(url);
      return Right(data);
    } on DioError catch (e) {
      logMe("Failure Product Repo ${e.error}");
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, CategoryListResponseModel>> getCategoryList() async {
    try {
      final data = await dataSource.getCategoryList();
      return Right(data);
    } on DioError catch (e) {
      logMe("Failure Login Repo ${e.error}");
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<BrandList>>> getBrandList() async {
    try {
      final data = await dataSource.getBrandList();
      return Right(data);
    } on DioError catch (e) {
      logMe("Failure Brand Repo ${e.error}");
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, ProductDetail>> getProductDetail(
      String productId) async {
    try {
      final data = await dataSource.getProductDetail(productId);
      return Right(data);
    } on DioError catch (e) {
      logMe("Failure Login Repo ${e.error}");
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, VariantList>> getProductVariant(
      String productId) async {
    try {
      final data = await dataSource.getProductVariant(productId);
      return Right(data);
    } on DioError catch (e) {
      logMe("Failure Login Repo ${e.error}");
      return const Left(ServerFailure());
    }
  }
}
