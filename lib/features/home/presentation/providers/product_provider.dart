import 'package:flutter/material.dart';
import 'package:pas_mobile/core/utility/helper.dart';
import 'package:pas_mobile/features/home/data/models/product_list_response_model.dart';
import 'package:pas_mobile/features/home/domain/usecases/get_product_list.dart';

import 'product_state.dart';

class ProductProvider extends ChangeNotifier {
  // initial
  final GetProductList getProductList;
  static List<Product> _listProduct = [];

  // getter
  List<Product> get listProduct => _listProduct;

  // constructor
  ProductProvider({
    required this.getProductList,
  });

  Stream<ProductState> fetchProductList() async* {
    yield ProductLoading();

    final result = await getProductList();
    yield* result.fold(
      (failure) async* {
        yield ProductFailure(failure: failure);
      },
      (data) async* {
        _listProduct = data.data;
        yield ProductLoaded(data: _listProduct);
      },
    );
  }
}
