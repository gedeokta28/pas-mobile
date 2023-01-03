import 'package:flutter/material.dart';
import 'package:pas_mobile/core/utility/enum.dart';
import 'package:pas_mobile/features/search/data/models/filter_parameter.dart';
import 'package:pas_mobile/features/search/data/models/filter_product_model.dart';
import 'package:pas_mobile/features/search/data/models/search_product_response_model.dart';
import 'package:pas_mobile/features/search/domain/usecases/do_filter_product.dart';
import 'package:pas_mobile/features/search/domain/usecases/do_search_product.dart';
import 'package:pas_mobile/features/search/presentation/providers/search_state.dart';

import '../../../home/domain/usecases/get_product_list.dart';

class SearchProvider with ChangeNotifier {
  final GetProductList getProductList;
  final DoSearchProduct doSearchProduct;
  final DoFilterProduct doFilterProduct;
  SearchProvider(
      {required this.getProductList,
      required this.doSearchProduct,
      required this.doFilterProduct});

  // initial
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  late List<ProductSearch> _listProductSearch = [];
  late List<ProductFilter> _listProductFilter = [];
  String _selectedValue = "terbaru";
  bool _isFocus = false;
  bool _isLoadingSearch = false;
  bool _isLoadingProduct = false;
  bool _isSearch = false;
  bool _isSearchResult = false;

  // getter
  TextEditingController get controller => _controller;
  String get selectedValue => _selectedValue;
  FocusNode get focusNode => _focusNode;
  bool get isFocus => _isFocus;
  bool get isLoadingSearch => _isLoadingSearch;
  bool get isLoadingProduct => _isLoadingProduct;
  bool get isSearch => _isSearch;
  bool get isSearchResult => _isSearchResult;
  List<ProductSearch> get listProductSearch => _listProductSearch;
  List<ProductFilter> get listProductFilter => _listProductFilter;

  // setter
  set setSelectedVal(val) {
    _selectedValue = val;
    notifyListeners();
  }

  set setFocus(focus) {
    _isFocus = focus;
    notifyListeners();
  }

  clearList() {
    _listProductSearch.clear();
    notifyListeners();
  }

  focus() {
    _focusNode.requestFocus();
  }

  unfocus() {
    _focusNode.unfocus();
  }

  setValueText(String value) {
    _controller.text = value;
    unfocus();
    notifyListeners();
  }

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(child: Text("Produk Termahal"), value: "termahal"),
      const DropdownMenuItem(child: Text("Produk Termurah"), value: "termurah"),
      const DropdownMenuItem(child: Text("Produk Terbaru"), value: "terbaru"),
    ];
    return menuItems;
  }

  Stream<SearchState> searchProductList(String keyword) async* {
    if (controller.text.isEmpty) {
      _isSearch = false;
      notifyListeners();
    } else {
      _isSearch = true;
      _isLoadingSearch = true;
      notifyListeners();
    }

    yield SearchLoading();
    final result = await doSearchProduct(keyword);
    yield* result.fold(
      (failure) async* {
        _isLoadingSearch = false;
        notifyListeners();
        yield SearchFailure(failure: failure);
      },
      (data) async* {
        _isLoadingSearch = false;
        _listProductSearch = data;
        notifyListeners();
        yield SearchLoaded(data: data);
      },
    );
  }

  Stream<SearchState> filterProduct(String keyword) async* {
    _controller.text = keyword;
    unfocus();
    _isSearch = false;
    _isSearchResult = true;
    _isLoadingProduct = true;
    notifyListeners();
    yield SearchLoading();
    final result = await doFilterProduct(
        TypeFilter.onlyKeyword, FilterParameter(keyword: keyword));
    yield* result.fold(
      (failure) async* {
        _isLoadingProduct = false;
        notifyListeners();
        yield SearchFailure(failure: failure);
      },
      (data) async* {
        _isLoadingProduct = false;
        _listProductFilter = data;
        notifyListeners();
        yield FilterLoaded(data: data);
      },
    );
  }
}
