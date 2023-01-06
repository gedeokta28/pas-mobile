import 'package:flutter/material.dart';
import 'package:pas_mobile/core/utility/helper.dart';
import 'package:pas_mobile/features/home/data/models/detail_product_model.dart';
import 'package:pas_mobile/features/home/domain/usecases/get_product_detail.dart';

import 'product_detail_state.dart';

class ProductProvider extends ChangeNotifier {
  // initial

  List<ImageProductDetail> _listImage = [];
  late ProductDetail _productDetail;
  int _indexImage = 0;
  bool _isLoadingProduct = true;

  List<ImageProductDetail> get listImage => _listImage;
  int get indexImage => _indexImage;
  bool get isLoadingProduct => _isLoadingProduct;
  ProductDetail get productDetail => _productDetail;

  set setIndexImage(value) {
    _indexImage = value;
    notifyListeners();
  }

  setProductImage() {
    _indexImage = 0;
    notifyListeners();
  }

  // String getIndex() {
  //   String element = _listImage.elementAt(_indexImage).url;
  //   logMe("elementelementelement");
  //   logMe(element);
  //   return element;
  // }

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
        _listImage = data.imagesProductDetail;
        _isLoadingProduct = false;
        logMe("_listImage_listImage_listImage");
        logMe(_indexImage);
        notifyListeners();
        yield ProductDetailLoaded(data: data);
      },
    );
  }

  // constructor
  final GetProductDetail getProductDetail;

  ProductProvider({required this.getProductDetail});
}
