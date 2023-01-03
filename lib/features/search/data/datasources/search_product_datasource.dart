import 'package:dio/dio.dart';
import 'package:pas_mobile/features/search/data/models/filter_parameter.dart';
import 'package:pas_mobile/features/search/data/models/filter_product_model.dart';
import 'package:pas_mobile/features/search/data/models/search_product_response_model.dart';

import '../../../../../core/utility/helper.dart';
import '../../../../core/utility/enum.dart';

abstract class SearchProductDataSource {
  Future<List<ProductSearch>> doSearchProduct(String keyword);
  Future<List<ProductFilter>> doFilterProduct(
      TypeFilter typeFilter, FilterParameter filterParameter);
}

class SearchProductDataSourceImplementation implements SearchProductDataSource {
  final Dio dio;

  SearchProductDataSourceImplementation({required this.dio});

  @override
  Future<List<ProductSearch>> doSearchProduct(String keyword) async {
    String url = 'api/search/keywords/products?q=$keyword';

    try {
      final response = await dio.get(
        url,
        options: options(headers: null),
      );
      final model = SearchProductModelResponse.fromJson(response.data);
      return model.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<ProductFilter>> doFilterProduct(
      TypeFilter typeFilter, FilterParameter filterParameter) async {
    String url;
    if (typeFilter == TypeFilter.onlyKeyword) {
      url =
          'api/search/item/products?order=${filterParameter.orderBy}&q=${filterParameter.keyword}';
    } else if (typeFilter == TypeFilter.customFilter) {
      url =
          'api/search/item/products?order=${filterParameter.orderBy}&q=${filterParameter.keyword}&pricestart=${filterParameter.priceStart}&priceend=${filterParameter.priceEnd}&categoryid=${filterParameter.categoryId}';
    } else {
      url =
          'api/search/item/products?order=${filterParameter.orderBy}&q=${filterParameter.keyword}';
    }

    try {
      final response = await dio.get(
        url,
        options: options(headers: null),
      );
      final model = FilterProductProductModel.fromJson(response.data);
      return model.data;
    } catch (e) {
      rethrow;
    }
  }
}
