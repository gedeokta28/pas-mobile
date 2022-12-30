import 'package:flutter/material.dart';
import 'package:pas_mobile/core/utility/helper.dart';
import 'package:pas_mobile/features/home/data/models/product_list_response_model.dart';
import 'package:pas_mobile/features/home/domain/usecases/get_product_list.dart';

import '../../../home/domain/usecases/get_category_list.dart';
import '../../../home/presentation/providers/category_selection_state.dart';
import '../../../home/presentation/providers/product_state.dart';

class SearchResultProvider extends ChangeNotifier {
  // initial
  final GetCategoryList getCategoryList;
  final GetProductList getProductList;
  static List<Product> _listProduct = [];
  late bool _productLoaded = false;
  String _selectedValue = "terbaru";
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(child: Text("Produk Termahal"), value: "termahal"),
      const DropdownMenuItem(child: Text("Produk Termurah"), value: "termurah"),
      const DropdownMenuItem(child: Text("Produk Terbaru"), value: "terbaru"),
    ];
    return menuItems;
  }

  // getter
  List<Product> get listProduct => _listProduct;
  bool get productLoaded => _productLoaded;
  String get selectedValue => _selectedValue;

  //set
  set setSelectedVal(val) {
    _selectedValue = val;
    notifyListeners();
  }

  // constructor
  SearchResultProvider(
      {required this.getProductList, required this.getCategoryList});

  Stream<ProductState> fetchProductList() async* {
    yield ProductLoading();

    final result = await getProductList();
    yield* result.fold(
      (failure) async* {
        yield ProductFailure(failure: failure);
      },
      (data) async* {
        _listProduct = data.data;
        _productLoaded = true;
        notifyListeners();
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
}
