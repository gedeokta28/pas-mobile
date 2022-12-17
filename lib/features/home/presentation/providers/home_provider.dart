import 'package:flutter/material.dart';
import 'package:pas_mobile/core/utility/helper.dart';
import 'package:pas_mobile/features/home/data/models/product_list_response_model.dart';
import 'package:pas_mobile/features/home/domain/usecases/get_product_list.dart';

import '../../domain/usecases/get_category_list.dart';
import 'category_selection_state.dart';
import 'product_state.dart';

class HomeProvider extends ChangeNotifier {
  // initial
  final GetCategoryList getCategoryList;
  final GetProductList getProductList;
  static List<Product> _listProduct = [];

  // getter
  List<Product> get listProduct => _listProduct;

  // constructor
  HomeProvider({required this.getProductList, required this.getCategoryList});

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

  Stream<CategorySelectionState> fetchCategoryList() async* {
    yield CategorySelectionLoading();

    final result = await getCategoryList();
    yield* result.fold(
      (failure) async* {
        yield CategorySelectionFailure(failure: failure);
      },
      (data) async* {
        yield CategorySelectionLoaded(data: data.data);
      },
    );
  }
}
