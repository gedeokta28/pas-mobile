import 'package:flutter/material.dart';
import 'package:pas_mobile/core/utility/helper.dart';
import 'package:pas_mobile/features/home/data/models/product_list_response_model.dart';
import 'package:pas_mobile/features/home/domain/usecases/get_product_list.dart';
import 'package:pas_mobile/features/search/domain/usecases/do_filter_product.dart';

import '../../../../core/utility/enum.dart';
import '../../../search/data/models/filter_parameter.dart';
import '../../../search/data/models/filter_product_model.dart';
import '../../../search/presentation/providers/search_state.dart';
import '../../domain/usecases/get_category_list.dart';
import 'category_selection_state.dart';
import 'product_state.dart';

class HomeProvider extends ChangeNotifier {
  // initial
  final GetCategoryList getCategoryList;
  final GetProductList getProductList;
  final DoFilterProduct doFilterProduct;
  late FilterParameter _filterParameterSelected = FilterParameter();
  static List<Product> _listProduct = [];
  late final ScrollController _scrollController =
      ScrollController(initialScrollOffset: 5.0)..addListener(_scrollListener);

  _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      if (_isStopLoad) {
        logMe("stopp");
      } else {
        _isLoadingMoreData = true;
        notifyListeners();

        if (_isLoadingMoreData) {
          if (_isStopLoad) {
            _isLoadingMoreData = false;
            notifyListeners();
          } else {
            _limitData = _limitData + 10;
            FilterParameter filterParameter = FilterParameter(
                limit: _limitData,
                brandId: _filterParameterSelected.brandId,
                categoryId: _filterParameterSelected.categoryId,
                keyword: _filterParameterSelected.keyword,
                priceEnd: _filterParameterSelected.priceEnd,
                priceStart: _filterParameterSelected.priceStart,
                priceBy: _filterParameterSelected.priceBy);
            filterCustomProductLoadMore(filterParameter).listen((event) {});
          }
        }
      }
    }
  }

  String _selectedValue = "terbaru";
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(child: Text("Produk Termahal"), value: "desc"),
      const DropdownMenuItem(child: Text("Produk Termurah"), value: "asc"),
      const DropdownMenuItem(child: Text("Produk Terbaru"), value: "terbaru"),
    ];
    return menuItems;
  }

  bool _isSearchResult = false;
  bool _isLoadingProduct = false;
  bool _isLoadingMoreData = false;
  bool _isStopLoad = false;
  int _limitData = 10;
  late List<ProductFilter> _listProductFilter = [];
  ScrollController get scrollController => _scrollController;

  bool get isSearchResult => _isSearchResult;
  bool get isLoadingProduct => _isLoadingProduct;
  FilterParameter get filterParameterSelected => _filterParameterSelected;
  bool get isStopLoad => _isStopLoad;
  bool get isLoadingMoreData => _isLoadingMoreData;
  int get limitData => _limitData;
  List<ProductFilter> get listProductFilter => _listProductFilter;

  // getter
  List<Product> get listProduct => _listProduct;
  String get selectedValue => _selectedValue;

  //set
  set setSelectedVal(val) {
    _selectedValue = val;
    notifyListeners();
  }

  // constructor
  HomeProvider(
      {required this.getProductList,
      required this.getCategoryList,
      required this.doFilterProduct});

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

  Stream<SearchState> filterCustomProduct(
      FilterParameter filterParameter) async* {
    logMe("keywordddd");
    _filterParameterSelected = filterParameter;
    _isSearchResult = true;
    _isLoadingProduct = true;
    _limitData = 10;
    _isStopLoad = false;
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
        _isLoadingProduct = false;
        _listProductFilter = data;
        if (_listProductFilter.length < _limitData) {
          logMe("stopppp");
          logMe(_limitData);
          _isStopLoad = true;
        }
        notifyListeners();
        yield FilterLoaded(data: data);
      },
    );
  }

  Stream<SearchState> filterCustomProductLoadMore(
      FilterParameter filterParameter) async* {
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
        _isLoadingMoreData = false;
        _listProductFilter.clear();
        _listProductFilter = data;
        if (_listProductFilter.length < _limitData) {
          _isStopLoad = true;
        }
        notifyListeners();
        yield FilterLoaded(data: data);
      },
    );
  }
}
