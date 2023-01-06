import 'package:flutter/material.dart';

import '../../../home/data/models/detail_product_model.dart';
import '../../../home/domain/usecases/get_product_detail.dart';
import 'product_detail_state.dart';

class AppBarProvider extends ChangeNotifier {
  // initial

  int _indexImage = 0;
  final GetProductDetail getProductDetail;
  bool _isLoadingProduct = true;
  List<ImageProductDetail> _listImage = [];

  List<ImageProductDetail> get listImage => _listImage;
  int get indexImage => _indexImage;
  bool get isLoadingProduct => _isLoadingProduct;

  set setIndexImage(value) {
    _indexImage = value;
    notifyListeners();
  }

  setProductImage() {
    _indexImage = 0;
    notifyListeners();
  }

  Future<void> setListImage(List<ImageProductDetail> listValue) async {
    _listImage = listValue;
    notifyListeners();
  }

  String getIndex() {
    String element = _listImage.elementAt(_indexImage).url;
    return element;
  }

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
        _isLoadingProduct = false;
        _listImage = data.imagesProductDetail;
        notifyListeners();
        yield ProductDetailLoaded(data: data);
      },
    );
  }

  // constructor
  AppBarProvider({required this.getProductDetail});
}
