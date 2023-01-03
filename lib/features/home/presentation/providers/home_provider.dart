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
  static List<Product> _listProduct = [];
  late FilterParameter _filterParameter =
      FilterParameter(keyword: '', priceEnd: 0, priceStart: 0);
  String _selectedValue = "terbaru";
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(child: Text("Produk Termahal"), value: "termahal"),
      const DropdownMenuItem(child: Text("Produk Termurah"), value: "termurah"),
      const DropdownMenuItem(child: Text("Produk Terbaru"), value: "terbaru"),
    ];
    return menuItems;
  }

  bool _isSearchResult = false;
  bool _isLoadingProduct = false;
  late List<ProductFilter> _listProductFilter = [];

  bool get isSearchResult => _isSearchResult;
  bool get isLoadingProduct => _isLoadingProduct;
  List<ProductFilter> get listProductFilter => _listProductFilter;

  // getter
  List<Product> get listProduct => _listProduct;
  String get selectedValue => _selectedValue;
  FilterParameter get filterParameter => _filterParameter;

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
        _isLoadingProduct = false;
        _listProductFilter = data;
        notifyListeners();
        yield FilterLoaded(data: data);
      },
    );
  }
}
