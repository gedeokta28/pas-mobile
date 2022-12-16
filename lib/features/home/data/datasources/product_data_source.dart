import 'package:dio/dio.dart';
import 'package:pas_mobile/features/home/data/models/product_list_response_model.dart';

import '../../../../core/utility/helper.dart';

abstract class ProductDataSource {
  Future<ProductListResponseModel> getProductList();
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
}
