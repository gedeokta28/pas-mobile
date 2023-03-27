import 'package:dio/dio.dart';
import 'package:pas_mobile/features/home/data/models/brand_list_response_model.dart';
import 'package:pas_mobile/features/home/data/models/category_list_response_model.dart';
import 'package:pas_mobile/features/home/data/models/product_list_response_model.dart';
import 'package:pas_mobile/features/home/data/models/variant_product_response_model.dart';

import '../../../../core/utility/helper.dart';
import '../models/detail_product_model.dart';

abstract class ProductDataSource {
  Future<ProductListResponseModel> getProductList();
  Future<ProductDetail> getProductDetail(String productId);
  Future<CategoryListResponseModel> getCategoryList();
  Future<List<BrandList>> getBrandList();
  Future<VariantList> getProductVariant(String productId);
}

class ProductDataSourceImplementation implements ProductDataSource {
  final Dio dio;

  ProductDataSourceImplementation({required this.dio});

  @override
  Future<ProductListResponseModel> getProductList() async {
    String url = 'api/products';

    try {
      final response = await dio.get(
        url,
        options: options(headers: null),
      );
      final model = ProductListResponseModel.fromJson(response.data);
      return model;
    } catch (e) {
      logMe("errorr");
      logMe(e);
      rethrow;
    }
  }

  @override
  Future<CategoryListResponseModel> getCategoryList() async {
    String url = 'api/categories';

    try {
      final response = await dio.get(
        url,
        options: options(headers: null),
      );
      final model = CategoryListResponseModel.fromJson(response.data);
      return model;
    } catch (e) {
      logMe("errorr");
      logMe(e);
      rethrow;
    }
  }

  @override
  Future<List<BrandList>> getBrandList() async {
    String url = 'api/brands';

    try {
      final response = await dio.get(
        url,
        options: options(headers: null),
      );
      final model = BrandListListResponseModel.fromJson(response.data);
      return model.data;
    } catch (e) {
      logMe("errorr");
      logMe(e);
      rethrow;
    }
  }

  @override
  Future<ProductDetail> getProductDetail(String productId) async {
    String url = 'api/products/$productId';

    try {
      final response = await dio.get(
        url,
        options: options(headers: null),
      );
      final model = DetailProductModel.fromJson(response.data);
      return model.data;
    } catch (e) {
      logMe("errorr");
      logMe(e);
      rethrow;
    }
  }

  @override
  Future<VariantList> getProductVariant(String productId) async {
    String url = 'api/products/$productId/variants';

    try {
      final response = await dio.get(
        url,
        options: options(headers: null),
      );
      final model = VariantProductModel.fromJson(response.data);
      return model.data;
    } catch (e) {
      logMe("errorr");
      logMe(e);
      rethrow;
    }
  }
}
