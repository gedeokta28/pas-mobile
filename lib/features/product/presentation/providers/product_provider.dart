import 'package:flutter/material.dart';
import 'package:pas_mobile/core/utility/helper.dart';
import 'package:pas_mobile/features/home/data/models/detail_product_model.dart';
import 'package:pas_mobile/features/home/domain/usecases/get_product_detail.dart';
import 'package:pas_mobile/features/search/data/models/filter_parameter.dart';
import 'package:pas_mobile/features/search/data/models/filter_product_model.dart';
import 'package:pas_mobile/features/search/domain/usecases/do_filter_product.dart';

import '../../../../core/utility/enum.dart';
import '../../../search/presentation/providers/search_state.dart';
import 'product_detail_state.dart';

class ProductProvider extends ChangeNotifier {
  // initial

  late ProductDetail _productDetail;
  late List<ProductFilter> _productRelated = [];
  bool _isLoadingProduct = true;
  bool _isLoadingRelated = true;

  bool get isLoadingProduct => _isLoadingProduct;
  bool get isLoadingRelated => _isLoadingRelated;
  ProductDetail get productDetail => _productDetail;
  List<ProductFilter> get productRelated => _productRelated;

  Stream<ProductDetailState> fetchProductDetail(String productId) async* {
    _isLoadingProduct = true;
    notifyListeners();
    yield ProductDetailLoading();
    final result = await getProductDetail(productId);
    yield* result.fold(
      (failure) async* {
        _isLoadingProduct = false;
        notifyListeners();
        yield ProductDetailFailure(failure: failure);
      },
      (data) async* {
        _productDetail = data;
        _isLoadingProduct = false;
        notifyListeners();
        yield ProductDetailLoaded(data: data);
      },
    );
  }

  Stream<SearchState> fetchRelatedProduct(
      String categoryId, String productId) async* {
    _isLoadingRelated = true;
    notifyListeners();
    FilterParameter filterParameter = FilterParameter(categoryId: categoryId);
    yield SearchLoading();
    final result =
        await doFilterProduct(TypeFilter.customFilter, filterParameter);
    yield* result.fold(
      (failure) async* {
        _isLoadingRelated = false;
        notifyListeners();
        yield SearchFailure(failure: failure);
      },
      (data) async* {
        _productRelated = data;
        await checkList(productId);
        _isLoadingRelated = false;
        notifyListeners();
        yield FilterLoaded(data: data);
      },
    );
  }

  checkList(String productId) {
    _productRelated.removeWhere((item) => item.stockid == productId);
  }

  // constructor
  final GetProductDetail getProductDetail;
  final DoFilterProduct doFilterProduct;

  ProductProvider(
      {required this.getProductDetail, required this.doFilterProduct});
}
