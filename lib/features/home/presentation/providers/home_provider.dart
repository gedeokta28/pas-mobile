import 'package:flutter/material.dart';
import 'package:pas_mobile/core/utility/helper.dart';
import 'package:pas_mobile/core/utility/injection.dart';
import 'package:pas_mobile/core/utility/session_helper.dart';
import 'package:pas_mobile/features/account/domain/usecases/get_profile.dart';
import 'package:pas_mobile/features/account/presentation/providers/profile_state.dart';
import 'package:pas_mobile/features/home/data/models/product_list_response_model.dart';
import 'package:pas_mobile/features/home/domain/usecases/get_customer_list.dart';
import 'package:pas_mobile/features/home/domain/usecases/get_product_list.dart';
import 'package:pas_mobile/features/home/presentation/providers/customer_list_state.dart';
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
  final GetProfile getProfile;
  final GetCustomerList getCustomerList;
  final GetProductList getProductList;
  final DoFilterProduct doFilterProduct;
  late FilterParameter _filterParameterSelected = FilterParameter();
  static List<Product> _listProduct = [];
  int _current = 0;
  late final ScrollController _scrollController =
      ScrollController(initialScrollOffset: 5.0)..addListener(_scrollListener);

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

        // if (_isLoadingMoreData) {
        // if (_isStopLoad) {
        //   _isLoadingMoreData = false;
        //   notifyListeners();
        // } else {
        _limitData = _limitData + 10;
        logMe('gett getttt');
        FilterParameter _filterParameter;
        if (_filterParameterSelected.sortBy.isEmpty) {
          _filterParameter = FilterParameter(
              limit: _limitData,
              brandId: _filterParameterSelected.brandId,
              categoryId: _filterParameterSelected.categoryId,
              keyword: _filterParameterSelected.keyword,
              priceEnd: _filterParameterSelected.priceEnd,
              priceStart: _filterParameterSelected.priceStart,
              priceBy: _filterParameterSelected.priceBy);
        } else {
          _filterParameter = FilterParameter(
            limit: _limitData,
            brandId: _filterParameterSelected.brandId,
            categoryId: _filterParameterSelected.categoryId,
            keyword: _filterParameterSelected.keyword,
            priceEnd: _filterParameterSelected.priceEnd,
            priceStart: _filterParameterSelected.priceStart,
            priceBy: '',
            sortBy: _filterParameterSelected.sortBy,
          );
        }

        filterCustomProductLoadMore(_filterParameter).listen((event) {});
        // }
      }
      // }
    }
  }

  String _selectedValue = "terbaru";
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(child: Text("Produk Termahal"), value: "desc"),
      const DropdownMenuItem(child: Text("Produk Termurah"), value: "asc"),
      const DropdownMenuItem(child: Text("Produk Terbaru"), value: "terbaru"),
      const DropdownMenuItem(child: Text("Produk Terlaris"), value: "terlaris"),
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
  int get current => _current;
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

  set setCurrent(val) {
    _current = val;
    notifyListeners();
  }

  // constructor
  HomeProvider(
      {required this.getProductList,
      required this.getCategoryList,
      required this.getProfile,
      required this.getCustomerList,
      required this.doFilterProduct});

  Stream<ProductState> fetchProductList(String? type) async* {
    yield ProductLoading();

    final result = await getProductList(type);
    yield* result.fold(
      (failure) async* {
        yield ProductFailure(failure: failure);
      },
      (data) async* {
        List<Product> dataFiltered =
            data.data.where((element) => element.discountinued == "0").toList();
        _listProduct = dataFiltered;
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

  Stream<CustomerListState> fetchCustomerList() async* {
    yield CustomerListLoading();
    final profileResult = await getProfile();
    yield* profileResult.fold((failure) async* {
      yield CustomerListFailure(failure: failure);
    }, (data) async* {
      locator<Session>().setSalesId = data.salespersonid;
      if (data.listcustomer == 'all') {
        locator<Session>().setAllCustomer = true;
      } else {
        locator<Session>().setCustomerId = data.customerid;
        locator<Session>().setCustomerName = data.customername;
        locator<Session>().setAllCustomer = false;
      }
      final result = await getCustomerList(data.listcustomer);
      yield* result.fold(
        (failure) async* {
          yield CustomerListFailure(failure: failure);
        },
        (data) async* {
          yield CustomerListLoaded(data: data);
        },
      );
    });
  }

  void setupInitFilter(FilterParameter? filterParameter) {
    if (filterParameter != null) {
      if (filterParameter.sortBy.isEmpty) {
        setSelectedVal = "terbaru";
      } else {
        setSelectedVal = "terlaris";
      }
    }
  }

  Stream<ProfileState> fetchProfile() async* {
    yield ProfileLoading();
  }

  Stream<SearchState> filterCustomProduct(
      FilterParameter filterParameter) async* {
    if (filterParameter.priceBy == 'desc' || filterParameter.priceBy == 'asc') {
      _selectedValue = filterParameter.priceBy;
    }
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
        List<ProductFilter> dataFilteredDisc =
            data.where((element) => element.discountinued == "0").toList();
        List<ProductFilter> dataFilteredDiscFalse =
            data.where((element) => element.discountinued == "1").toList();
        _listProductFilter = dataFilteredDisc;

        if ((dataFilteredDisc.length + dataFilteredDiscFalse.length) <
            _limitData) {
          logMe("stopppp");
          logMe(dataFilteredDisc.length);
          logMe(dataFilteredDiscFalse.length);
          logMe(_limitData);
          _isStopLoad = true;
        }
        notifyListeners();
        yield FilterLoaded(data: dataFilteredDisc);
      },
    );
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
        _isLoadingMoreData = false;
        _listProductFilter.clear();
        List<ProductFilter> dataFilteredDisc =
            data.where((element) => element.discountinued == "0").toList();
        List<ProductFilter> dataFilteredDiscFalse =
            data.where((element) => element.discountinued == "1").toList();
        _listProductFilter = dataFilteredDisc;
        if ((dataFilteredDisc.length + dataFilteredDiscFalse.length) <
            _limitData) {
          logMe("stopppp filterCustomProductLoadMore");
          logMe("stopppp ${dataFilteredDiscFalse.length}");
          logMe("stopppp ${dataFilteredDisc.length}");
          logMe("stopppp $_limitData");
          logMe(dataFilteredDisc.length);
          logMe(dataFilteredDiscFalse.length);
          logMe(_limitData);
          _isStopLoad = true;
        } else {
          logMe("nextt filterCustomProductLoadMore");
          logMe(dataFilteredDisc.length);
          logMe(dataFilteredDiscFalse.length);
          logMe(_limitData);
        }
        notifyListeners();
        yield FilterLoaded(data: data);
      },
    );
  }
}
