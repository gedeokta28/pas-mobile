import 'package:dio/dio.dart';
import 'package:pas_mobile/features/search/data/models/search_product_response_model.dart';

import '../../../../core/utility/helper.dart';

abstract class SearchProductDataSource {
  Future<List<ProductSearch>> doSearchProduct(String keyword);
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
}
