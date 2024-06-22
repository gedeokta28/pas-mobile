import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:pas_mobile/features/cart/data/models/price_grosir_model.dart';
import 'package:pas_mobile/features/home/domain/usecases/get_product_list_by_url.dart';
import 'package:pas_mobile/features/quick_order/data/product_quick_model.dart';
import 'package:pas_mobile/features/quick_order/data/quick_order_param.dart';
import 'package:pas_mobile/features/quick_order/presentation/providers/quick_order_state.dart';
import 'package:pas_mobile/features/quick_order/presentation/providers/quick_product_refresh_state.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utility/enum.dart';
import '../../../../core/utility/helper.dart';
import '../../../cart/domain/usecases/add_to_cart_quick_order.dart';
import '../../../home/data/models/product_list_response_model.dart';
import '../../../home/domain/usecases/get_product_list.dart';
import '../../../search/data/models/filter_parameter.dart';
import '../../../search/data/models/filter_product_model.dart';
import '../../../search/domain/usecases/do_filter_product.dart';
import 'quick_product_filter.dart';
import 'quick_product_state.dart';

class QuickOrderProvider extends ChangeNotifier {
  // initial
  final GetProductList getProductList;
  final GetProductListByUrl getProductListByUrl;
  final DoFilterProduct doFilterProduct;
  final AddToCartQuickOrder addToCartQuickOrder;
  QuickProductState _state = QuickProductInitial();
  QuickProductFilterState _stateSearch = QuickProductFilterInitial();
  late List<Product> _productList = [];
  String? _nextUrl;
  List<ProductQuick> _selectedProduct = [];
  List<ProductQuick> _quickOrderProduct = [];
  bool _isSearch = false;
  final TextEditingController _controller = TextEditingController();

  // constructor
  QuickOrderProvider({
    required this.getProductList,
    required this.getProductListByUrl,
    required this.addToCartQuickOrder,
    required this.doFilterProduct,
  });

  //get
  QuickProductState get state => _state;
  QuickProductFilterState get stateSearch => _stateSearch;
  TextEditingController get controller => _controller;
  bool get isSearch => _isSearch;
  List<Product> get productList => _productList;
  List<ProductQuick> get quickOrderProduct => _quickOrderProduct;
  String get nextUrl => _nextUrl ?? '';
  List<ProductQuick> get selectedProduct => _selectedProduct;

  //set
  set setState(val) {
    _state = val;
    notifyListeners();
  }

  set setStateSearch(val) {
    _stateSearch = val;
    notifyListeners();
  }

  set setIsSearch(val) {
    _isSearch = val;
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
    _quickOrderProduct.clear();
    showLoading();
    await Future.delayed(const Duration(milliseconds: 500));
    setState = QuickProductLoading();

    late Either<Failure, ProductListResponseModel> result;

    result = await getProductList(null);
    result.fold(
      (failure) {
        dismissLoading();
        setState = QuickProductFailure(failure: failure);
      },
      (data) {
        dismissLoading();
        setState = const QuickProductLoaded();
        List<Product> dataFiltered =
            data.data.where((element) => element.discountinued == "0").toList();
        setProductList = dataFiltered;
        for (var i = 0; i < dataFiltered.length; i++) {
          List<PriceGrosirCart> _priceGrosirCart = [];
          _priceGrosirCart.add(PriceGrosirCart(
            minUnit: toIntQty(dataFiltered[i].qty1),
            maxUnit: toIntQty(dataFiltered[i].qty2) - 1,
            price: convertPriceDisc(
                dataFiltered[i].hrg1, dataFiltered[i].disclist1),
          ));
          _priceGrosirCart.add(PriceGrosirCart(
            minUnit: toIntQty(dataFiltered[i].qty2),
            maxUnit: toIntQty(dataFiltered[i].qty3) - 1,
            price: convertPriceDisc(
                dataFiltered[i].hrg1, dataFiltered[i].disclist2),
          ));
          _priceGrosirCart.add(PriceGrosirCart(
            minUnit: toIntQty(dataFiltered[i].qty3),
            maxUnit: 0,
            price: convertPriceDisc(
                dataFiltered[i].hrg1, dataFiltered[i].disclist3),
          ));
          _priceGrosirCart.add(PriceGrosirCart(
            minUnit: toIntQty(dataFiltered[i].qty3),
            maxUnit: 0,
            price: convertPriceDisc(dataFiltered[i].hrg1, '0'),
          ));
          var arr = dataFiltered[i].hrg1.split('.');
          _quickOrderProduct.add(
            ProductQuick(
              id: dataFiltered[i].stockid,
              productId: dataFiltered[i].stockid,
              productName: dataFiltered[i].stockname,
              initialPrice: int.tryParse(arr[0]),
              productPrice: ValueNotifier(int.parse(arr[0])),
              quantity: ValueNotifier(1),
              unitTag: "unitTag",
              // image: dataFiltered[i].photourl == null
              //     ? ''
              //     : dataFiltered[i].photourl!,
              image: dataFiltered[i].images.isEmpty
                  ? ''
                  : dataFiltered[i].images[0].url,
              priceGrosirProductQuick: _priceGrosirCart,
              hrg1: dataFiltered[i].hrg1,
              hrg2: dataFiltered[i].hrg2,
              hrg3: dataFiltered[i].hrg3,
              unit1: dataFiltered[i].unit1,
              unit2: dataFiltered[i].unit2,
              unit3: dataFiltered[i].unit3,
              disclist1: dataFiltered[i].disclist1,
              disclist2: dataFiltered[i].disclist2,
              disclist3: dataFiltered[i].disclist3,
              qty1: dataFiltered[i].qty1,
              qty2: dataFiltered[i].qty2,
              qty3: dataFiltered[i].qty3,
            ),
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
        List<Product> dataFiltered =
            data.data.where((element) => element.discountinued == "0").toList();
        temp.addAll(dataFiltered);
        for (var i = 0; i < dataFiltered.length; i++) {
          List<PriceGrosirCart> _priceGrosirCart = [];
          _priceGrosirCart.add(PriceGrosirCart(
            minUnit: toIntQty(dataFiltered[i].qty1),
            maxUnit: toIntQty(dataFiltered[i].qty2) - 1,
            price: convertPriceDisc(
                dataFiltered[i].hrg1, dataFiltered[i].disclist1),
          ));
          _priceGrosirCart.add(PriceGrosirCart(
            minUnit: toIntQty(dataFiltered[i].qty2),
            maxUnit: toIntQty(dataFiltered[i].qty3) - 1,
            price: convertPriceDisc(
                dataFiltered[i].hrg1, dataFiltered[i].disclist2),
          ));
          _priceGrosirCart.add(PriceGrosirCart(
            minUnit: toIntQty(dataFiltered[i].qty3),
            maxUnit: 0,
            price: convertPriceDisc(
                dataFiltered[i].hrg1, dataFiltered[i].disclist3),
          ));
          _priceGrosirCart.add(PriceGrosirCart(
            minUnit: toIntQty(dataFiltered[i].qty3),
            maxUnit: 0,
            price: convertPriceDisc(dataFiltered[i].hrg1, '0'),
          ));
          var arr = dataFiltered[i].hrg1.split('.');
          _quickOrderProduct.add(
            ProductQuick(
              id: dataFiltered[i].stockid,
              productId: dataFiltered[i].stockid,
              productName: dataFiltered[i].stockname,
              initialPrice: int.tryParse(arr[0]),
              productPrice: ValueNotifier(int.parse(arr[0])),
              quantity: ValueNotifier(1),
              unitTag: "unitTag",
              // image: dataFiltered[i].photourl == null
              //     ? ''
              //     : dataFiltered[i].photourl!,
              image: dataFiltered[i].images.isEmpty
                  ? ''
                  : dataFiltered[i].images[0].url,

              priceGrosirProductQuick: _priceGrosirCart,
              hrg1: dataFiltered[i].hrg1,
              hrg2: dataFiltered[i].hrg2,
              hrg3: dataFiltered[i].hrg3,
              unit1: dataFiltered[i].unit1,
              unit2: dataFiltered[i].unit2,
              unit3: dataFiltered[i].unit3,
              disclist1: dataFiltered[i].disclist1,
              disclist2: dataFiltered[i].disclist2,
              disclist3: dataFiltered[i].disclist3,
              qty1: dataFiltered[i].qty1,
              qty2: dataFiltered[i].qty2,
              qty3: dataFiltered[i].qty3,
            ),
          );
        }
        setProductList = temp;
        yield QuickProductRefreshLoaded(data: dataFiltered);
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
    logMe(_quickOrderProduct[index].quantity!.value + 1);
    notifyListeners();
  }

  void changeQuantity(String id, String value) {
    final index = _quickOrderProduct.indexWhere((element) => element.id == id);
    _quickOrderProduct[index].quantity!.value = int.parse(value);

    notifyListeners();
  }

  void deleteQuantity(String id) {
    final index = _quickOrderProduct.indexWhere((element) => element.id == id);
    final currentQuantity = _quickOrderProduct[index].quantity!.value;
    if (currentQuantity <= 1) {
      currentQuantity == 1;
    } else {
      _quickOrderProduct[index].quantity!.value = currentQuantity - 1;
    }

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

  Future<void> filterProduct(String keyword) async {
    _quickOrderProduct.clear();
    showLoading();
    await Future.delayed(const Duration(milliseconds: 500));
    setStateSearch = QuickProductFilterLoading();
    late Either<Failure, List<ProductFilter>> result;

    result = await doFilterProduct(TypeFilter.customFilter,
        FilterParameter(keyword: keyword, limit: 1000));
    result.fold(
      (failure) {
        dismissLoading();
        setStateSearch = QuickProductFailure(failure: failure);
      },
      (data) {
        List<ProductFilter> _result = [];
        _result = data;
        _result.sort((a, b) {
          return a.stockname.toLowerCase().compareTo(b.stockname.toLowerCase());
        });
        for (var i = 0; i < _result.length; i++) {
          List<PriceGrosirCart> _priceGrosirCart = [];
          _priceGrosirCart.add(PriceGrosirCart(
            minUnit: toIntQty(_result[i].qty1),
            maxUnit: toIntQty(_result[i].qty2) - 1,
            price: convertPriceDisc(_result[i].hrg1, _result[i].disclist1),
          ));
          _priceGrosirCart.add(PriceGrosirCart(
            minUnit: toIntQty(_result[i].qty2),
            maxUnit: toIntQty(_result[i].qty3) - 1,
            price: convertPriceDisc(_result[i].hrg1, _result[i].disclist2),
          ));
          _priceGrosirCart.add(PriceGrosirCart(
            minUnit: toIntQty(_result[i].qty3),
            maxUnit: 0,
            price: convertPriceDisc(_result[i].hrg1, _result[i].disclist3),
          ));
          _priceGrosirCart.add(PriceGrosirCart(
            minUnit: toIntQty(_result[i].qty3),
            maxUnit: 0,
            price: convertPriceDisc(_result[i].hrg1, '0'),
          ));
          var arr = _result[i].hrg1.split('.');
          _quickOrderProduct.add(
            ProductQuick(
                hrg1: _result[i].hrg1,
                hrg2: _result[i].hrg2,
                hrg3: _result[i].hrg3,
                unit1: _result[i].unit1,
                unit2: _result[i].unit2,
                unit3: _result[i].unit3,
                disclist1: _result[i].disclist1,
                disclist2: _result[i].disclist2,
                disclist3: _result[i].disclist3,
                qty1: _result[i].qty1,
                qty2: _result[i].qty2,
                qty3: _result[i].qty3,
                id: _result[i].stockid,
                productId: _result[i].stockid,
                productName: _result[i].stockname,
                initialPrice: int.tryParse(arr[0]),
                productPrice: ValueNotifier(int.parse(arr[0])),
                quantity: ValueNotifier(1),
                unitTag: "unitTag",
                // image: _result[i].photourl == null ? '' : _result[i].photourl!,
                image:
                    _result[i].images.isEmpty ? '' : _result[i].images[0].url,
                priceGrosirProductQuick: _priceGrosirCart),
          );
        }
        dismissLoading();
        setStateSearch = QuickProductFilterLoaded(data: _result);
      },
    );
  }
}
