import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:pas_mobile/features/home/domain/usecases/get_product_list_by_url.dart';
import 'package:pas_mobile/features/quick_order/data/product_quick_model.dart';
import 'package:pas_mobile/features/quick_order/data/quick_order_param.dart';
import 'package:pas_mobile/features/quick_order/presentation/providers/quick_order_state.dart';
import 'package:pas_mobile/features/quick_order/presentation/providers/quick_product_refresh_state.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utility/helper.dart';
import '../../../cart/domain/usecases/add_to_cart_quick_order.dart';
import '../../../home/data/models/product_list_response_model.dart';
import '../../../home/domain/usecases/get_product_list.dart';
import 'quick_product_state.dart';

class QuickOrderProvider extends ChangeNotifier {
  // initial
  final GetProductList getProductList;
  final GetProductListByUrl getProductListByUrl;
  final AddToCartQuickOrder addToCartQuickOrder;
  QuickProductState _state = QuickProductInitial();
  late List<Product> _productList = [];
  String? _nextUrl;
  List<ProductQuick> _selectedProduct = [];
  // List<Product> _selectedProduct = [];
  List<ProductQuick> _quickOrderProduct = [];

  // constructor
  QuickOrderProvider({
    required this.getProductList,
    required this.getProductListByUrl,
    required this.addToCartQuickOrder,
  });

  //get
  QuickProductState get state => _state;
  List<Product> get productList => _productList;
  List<ProductQuick> get quickOrderProduct => _quickOrderProduct;
  String get nextUrl => _nextUrl ?? '';
  // List<Product> get selectedProduct => _selectedProduct;
  List<ProductQuick> get selectedProduct => _selectedProduct;

  //set
  set setState(val) {
    _state = val;
    notifyListeners();
  }

  set setQuickProduct(val) {
    _quickOrderProduct = val;
    notifyListeners();
  }

  set setProductList(val) {
    _productList = val;
    notifyListeners();
  }

  set setNextUrl(val) {
    _nextUrl = val;
    notifyListeners();
  }

  set setSelectedProduct(value) {
    _selectedProduct = value;
    notifyListeners();
  }

  addSelectedProduct(val) {
    _selectedProduct.add(val);
    notifyListeners();
  }

  removeSelectedProduct(ProductQuick val) {
    _selectedProduct.removeWhere((item) => item.id == val.id);
    notifyListeners();
  }

  Future<void> fetchProduct() async {
    await Future.delayed(const Duration(milliseconds: 500));
    setState = QuickProductLoading();

    late Either<Failure, ProductListResponseModel> result;

    result = await getProductList();
    await Future.delayed(const Duration(milliseconds: 500));
    result.fold(
      (failure) => setState = QuickProductFailure(failure: failure),
      (data) {
        setState = const QuickProductLoaded();
        setProductList = data.data;
        for (var i = 0; i < data.data.length; i++) {
          var arr = data.data[i].hrg1.split('.');
          _quickOrderProduct.add(
            ProductQuick(
                id: data.data[i].stockid,
                productId: data.data[i].stockid,
                productName: data.data[i].stockname,
                initialPrice: int.tryParse(arr[0]),
                productPrice: ValueNotifier(int.parse(arr[0])),
                quantity: ValueNotifier(1),
                unitTag: "unitTag",
                image:
                    data.data[i].photourl == null ? '' : data.data[i].photourl!,
                priceGrosirProductQuick: null),
          );
        }

        setNextUrl = data.links.next ?? '';
      },
    );
  }

  Stream<QuickProductRefreshState> fetchNextData(String url) async* {
    yield QuickProductRefreshInitial();
    final result = await getProductListByUrl(url);
    yield* result.fold(
      (_) async* {
        yield QuickProductRefreshFailure();
      },
      (data) async* {
        setNextUrl = data.links.next ?? '';
        final temp = List<Product>.from(_productList);
        temp.addAll(data.data);
        for (var i = 0; i < data.data.length; i++) {
          var arr = data.data[i].hrg1.split('.');
          _quickOrderProduct.add(
            ProductQuick(
                id: data.data[i].stockid,
                productId: data.data[i].stockid,
                productName: data.data[i].stockname,
                initialPrice: int.tryParse(arr[0]),
                productPrice: ValueNotifier(int.parse(arr[0])),
                quantity: ValueNotifier(1),
                unitTag: "unitTag",
                image:
                    data.data[i].photourl == null ? '' : data.data[i].photourl!,
                priceGrosirProductQuick: null),
          );
        }
        setProductList = temp;
        yield QuickProductRefreshLoaded(data: data.data);
      },
    );
  }

  bool isDataExist(String value) {
    var data = _selectedProduct.where((row) => (row.id == value));
    if (data.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  void addQuantity(String id) {
    final index = _quickOrderProduct.indexWhere((element) => element.id == id);
    _quickOrderProduct[index].quantity!.value =
        _quickOrderProduct[index].quantity!.value + 1;

    notifyListeners();
  }

  Stream<AddToCartQuickOrderState> addToCart() async* {
    yield AddToCartQuickOrderLoading();
    List<QuickCartParam> cartItems = [];
    for (var i = 0; i < _selectedProduct.length; i++) {
      QuickCartParam _cartParam;
      _cartParam = QuickCartParam(
        stockId: _selectedProduct[i].id,
        quantity: _selectedProduct[i].quantity!.value,
      );
      cartItems.add(_cartParam);
    }
    CartListParam cartList = CartListParam(carts: cartItems);
    Map<String, dynamic> payload = {"carts": cartList.toJson()};
    String payloadJson = json.encode(payload);
    final resultOder = await addToCartQuickOrder.execute(payloadJson);
    yield* resultOder.fold((failure) async* {
      logMe("failure.message ${failure.message}");
      yield AddToCartQuickOrderFailure(failure: failure);
    }, (result) async* {
      logMe('suksessssss $result');
      yield AddToCartQuickOrderSuccess(data: result);
    });
  }

  testCart() {
    List<QuickCartParam> cartItems = [];
    for (var i = 0; i < _selectedProduct.length; i++) {
      QuickCartParam _cartParam;
      _cartParam = QuickCartParam(
        stockId: _selectedProduct[i].id,
        quantity: _selectedProduct[i].quantity!.value,
      );
      cartItems.add(_cartParam);
    }
    CartListParam cartList = CartListParam(carts: cartItems);
    // String jsonStr = json.encode(cartList.toJson());
    Map<String, dynamic> payload = {"carts": cartList.toJson()};
    String payloadJson = json.encode(payload);
    logMe(payloadJson);
  }
}
