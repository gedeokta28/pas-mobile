import 'package:flutter/material.dart';
import 'package:pas_mobile/core/utility/enum.dart';
import 'package:pas_mobile/core/utility/helper.dart';
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
  late FilterParameter _filterParameterSelected = FilterParameter();
  final FocusNode _focusNode = FocusNode();
  late List<ProductSearch> _listProductSearch = [];
  bool _isLoadingMoreData = false;
  bool _isStopLoad = false;
  int _limitData = 10;
  late List<ProductFilter> _listProductFilter = [];
  String _selectedValue = "terbaru";
  bool _isFocus = false;
  bool _isLoadingSearch = false;
  bool _isLoadingProduct = false;
  bool _isSearch = false;
  bool _isSearchResult = false;
  late final ScrollController _scrollController =
      ScrollController(initialScrollOffset: 5.0)..addListener(_scrollListener);
  // getter
  TextEditingController get controller => _controller;
  String get selectedValue => _selectedValue;
  FilterParameter get filterParameterSelected => _filterParameterSelected;
  FocusNode get focusNode => _focusNode;
  bool get isFocus => _isFocus;
  bool get isStopLoad => _isStopLoad;
  bool get isLoadingMoreData => _isLoadingMoreData;
  bool get isLoadingSearch => _isLoadingSearch;
  bool get isLoadingProduct => _isLoadingProduct;
  bool get isSearch => _isSearch;
  ScrollController get scrollController => _scrollController;
  bool get isSearchResult => _isSearchResult;
  List<ProductSearch> get listProductSearch => _listProductSearch;
  List<ProductFilter> get listProductFilter => _listProductFilter;
  _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      if (_isStopLoad) {
        logMe("stopp");
      } else {
        logMe('gett notifyListeners');
        _isLoadingMoreData = true;
        notifyListeners();
        _limitData = _limitData + 10;
        logMe('gett getttt');
        FilterParameter filterParameter = FilterParameter(
            limit: _limitData,
            brandId: _filterParameterSelected.brandId,
            categoryId: _filterParameterSelected.categoryId,
            keyword: _controller.text,
            priceEnd: _filterParameterSelected.priceEnd,
            priceStart: _filterParameterSelected.priceStart,
            priceBy: _filterParameterSelected.priceBy);
        filterCustomProductLoadMore(filterParameter).listen((event) {});
        // }
      }
      // }
    }
  }

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

  updateFilter(String sa) {
    showShortToast(message: "message");
    notifyListeners();
  }

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(child: Text("Produk Termahal"), value: "desc"),
      const DropdownMenuItem(child: Text("Produk Termurah"), value: "asc"),
      const DropdownMenuItem(child: Text("Produk Terbaru"), value: "terbaru"),
    ];
    return menuItems;
  }

  Stream<SearchState> filterCustomProductLoadMore(
      FilterParameter filterParameter) async* {
    _isLoadingMoreData = true;
    yield SearchLoading();
    final result =
        await doFilterProduct(TypeFilter.customFilter, filterParameter);
    yield* result.fold(
      (failure) async* {
        _isLoadingMoreData = false;
        notifyListeners();
        yield SearchFailure(failure: failure);
      },
      (data) async* {
        print("mantapss");
        _isLoadingMoreData = false;
        // data.sort((a, b) {
        //   return a.stockname.toLowerCase().compareTo(b.stockname.toLowerCase());
        // });
        _listProductFilter.clear();
        List<ProductFilter> dataFilteredDisc =
            data.where((element) => element.discountinued == "0").toList();
        List<ProductFilter> dataFilteredDiscFalse =
            data.where((element) => element.discountinued == "1").toList();
        _listProductFilter = dataFilteredDisc;
        // if ((dataFilteredDisc.length + dataFilteredDiscFalse.length) <
        //     _limitData) {
        //   logMe("stopppp filterCustomProductLoadMore");
        //   logMe("stopppp ${dataFilteredDiscFalse.length}");
        //   logMe("stopppp ${dataFilteredDisc.length}");
        //   logMe("stopppp $_limitData");
        //   logMe(dataFilteredDisc.length);
        //   logMe(dataFilteredDiscFalse.length);
        //   logMe(_limitData);
        //   _isStopLoad = true;
        // } else {
        // logMe("nextt filterCustomProductLoadMore");
        // logMe(dataFilteredDisc.length);
        // logMe(dataFilteredDiscFalse.length);
        // logMe(_limitData);
        // }
        notifyListeners();
        yield FilterLoaded(data: data);
      },
    );
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
        print("searchProductList");

        _isLoadingSearch = false;
        _listProductSearch = data;
        notifyListeners();
        data.sort((a, b) {
          return a.stockname.toLowerCase().compareTo(b.stockname.toLowerCase());
        });
        print("dataa");
        print(data);
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
        TypeFilter.customFilter, FilterParameter(keyword: keyword));
    yield* result.fold(
      (failure) async* {
        _isLoadingProduct = false;
        notifyListeners();
        yield SearchFailure(failure: failure);
      },
      (data) async* {
        print("filterProduct");

        _isLoadingProduct = false;
        // data.sort((a, b) {
        //   return a.stockname.toLowerCase().compareTo(b.stockname.toLowerCase());
        // });
        List<ProductFilter> dataFiltered =
            data.where((element) => element.discountinued == "0").toList();
        _listProductFilter = dataFiltered;
        notifyListeners();

        yield FilterLoaded(data: data);
      },
    );
  }

  Stream<SearchState> filterCustomProduct(
      FilterParameter filterParameter) async* {
    unfocus();
    _filterParameterSelected = filterParameter;
    _isSearch = false;
    _isSearchResult = true;
    _isLoadingProduct = true;
    notifyListeners();
    yield SearchLoading();
    final result =
        await doFilterProduct(TypeFilter.customFilter, filterParameter);
    yield* result.fold(
      (failure) async* {
        _isLoadingProduct = false;
        notifyListeners();
        yield SearchFailure(failure: failure);
      },
      (data) async* {
        print("mantapss");
        _isLoadingProduct = false;
        List<ProductFilter> dataFiltered =
            data.where((element) => element.discountinued == "0").toList();
        _listProductFilter = dataFiltered;
        notifyListeners();
        yield FilterLoaded(data: data);
      },
    );
  }
}
