import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:pas_mobile/features/home/domain/usecases/get_product_list_by_url.dart';
import 'package:pas_mobile/features/quick_order/presentation/providers/quick_product_refresh_state.dart';
import 'package:pas_mobile/features/quick_order/presentation/providers/quick_product_state.dart';

import '../../../../core/error/failures.dart';
import '../../../home/data/models/product_list_response_model.dart';
import '../../../home/domain/usecases/get_product_list.dart';

class BestProductProvider extends ChangeNotifier {
  // initial
  final GetProductList getProductList;
  final GetProductListByUrl getProductListByUrl;
  QuickProductState _state = QuickProductInitial();
  late List<Product> _productList = [];
  String? _nextUrl;
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(child: Text("Produk Termahal"), value: "desc"),
      const DropdownMenuItem(child: Text("Produk Termurah"), value: "asc"),
      const DropdownMenuItem(child: Text("Produk Terbaru"), value: "terbaru"),
    ];
    return menuItems;
  }

  // constructor
  BestProductProvider({
    required this.getProductList,
    required this.getProductListByUrl,
  });

  //get
  List<Product> get productList => _productList;
  String get nextUrl => _nextUrl ?? '';
  QuickProductState get state => _state;

  //set
  set setState(val) {
    _state = val;
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

  Future<void> fetchProduct() async {
    await Future.delayed(const Duration(milliseconds: 500));
    setState = QuickProductLoading();

    late Either<Failure, ProductListResponseModel> result;

    result = await getProductList('best-product');
    result.fold(
      (failure) {
        setState = QuickProductFailure(failure: failure);
      },
      (data) {
        setState = const QuickProductLoaded();
        setProductList = data.data;
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
        setProductList = temp;
        yield QuickProductRefreshLoaded(data: data.data);
      },
    );
  }
}
