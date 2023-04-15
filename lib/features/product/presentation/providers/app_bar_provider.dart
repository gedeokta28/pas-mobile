import 'package:flutter/material.dart';
import 'package:pas_mobile/core/utility/helper.dart';

import '../../../../core/utility/injection.dart';
import '../../../../core/utility/session_helper.dart';
import '../../../cart/domain/usecases/get_cart.dart';
import '../../../cart/presentation/providers/cart_item_state.dart';
import '../../../home/data/models/detail_product_model.dart';
import '../../../home/domain/usecases/get_product_detail.dart';
import 'product_detail_state.dart';

class AppBarProvider extends ChangeNotifier {
  // initial
  final session = locator<Session>();
  int _indexImage = 0;
  int _totalCartItem = 0;
  final GetProductDetail getProductDetail;
  final GetCart getCart;
  bool _isLoadingProduct = true;
  List<ImageProductDetail> _listImage = [];

  List<ImageProductDetail> get listImage => _listImage;
  int get indexImage => _indexImage;
  int get totalCartItem => _totalCartItem;
  bool get isLoadingProduct => _isLoadingProduct;

  set setIndexImage(value) {
    _indexImage = value;
    notifyListeners();
  }

  set setTotalCartItem(int value) {
    _totalCartItem = value;
    logMe(_totalCartItem);
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
        if (session.isLoggedIn) {
          countCartItem().listen((event) {
            if (event is CartItemSuccess) {
              _isLoadingProduct = false;
              if (data.imagesProductDetail.isEmpty && data.photourl != null) {
                _listImage.add(ImageProductDetail(id: "1", url: data.photourl));
              } else {
                _listImage = data.imagesProductDetail;
              }
              logMe(_listImage);
              notifyListeners();
              _totalCartItem = event.data.length;
              notifyListeners();
            }
          });
        } else {
          _isLoadingProduct = false;
          if (data.imagesProductDetail.isEmpty && data.photourl != null) {
            _listImage.add(ImageProductDetail(id: "1", url: data.photourl));
          } else {
            _listImage = data.imagesProductDetail;
          }
          notifyListeners();
        }
        yield ProductDetailLoaded(data: data);
      },
    );
  }

  Stream<CartItemState> countCartItem() async* {
    if (session.isLoggedIn) {
      yield CartItemLoading();

      final updateResult = await getCart.call();
      yield* updateResult.fold((failure) async* {
        logMe("failure.message ${failure.message}");
        yield CartItemFailure(failure: failure);
      }, (result) async* {
        yield CartItemSuccess(data: result);
      });
    }
  }

  void countTotalCartItem() async {
    if (session.isLoggedIn) {
      countCartItem().listen((event) {
        if (event is CartItemSuccess) {
          _totalCartItem = event.data.length;
          logMe(_totalCartItem);
          logMe('_totalCartItem');
          notifyListeners();
        }
      });
    }
  }

  // constructor
  AppBarProvider({required this.getProductDetail, required this.getCart});
}
