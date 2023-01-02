import 'package:flutter/material.dart';
import 'package:pas_mobile/core/utility/helper.dart';

import '../../../home/data/models/product_list_response_model.dart';
import '../../../home/domain/usecases/get_category_list.dart';
import '../../../home/domain/usecases/get_product_list.dart';
import '../../../home/presentation/providers/product_state.dart';

class SearchProvider with ChangeNotifier {
  SearchProvider({required this.getProductList});

  // initial
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  late List<Product> _listProduct = [];
  List<Product> get listProduct => _listProduct;

  bool _isFocus = false;
  bool _isLoading = false;
  bool _isEmpty = false;
  List<String> _listProductDummy = [
    "Bor Mesin",
    "Grinda Tangan",
    "Mesin Ketam",
    "Serutan Kayu",
    "Palu",
    "Tangga Lipat Aluminium",
    "Gergaji",
    "Obeng",
    "Kunci Inggris",
    "Tang",
    "Kapak",
    "Sekop",
    "Cetok",
    "Sendok Semen",
    "Mata Gergaji Besi",
    "Cangkul",
    "Materan"
  ];
  List<String> _listProductResult = [];
  bool _isSearch = false;
  bool _isSearchResult = false;

  // setter
  set setFocus(focus) {
    _isFocus = focus;
    notifyListeners();
  }

  set setLoading(loading) {
    _isLoading = loading;
    notifyListeners();
  }

  set setSearch(search) {
    if (controller.text.isEmpty) {
      _isSearch = false;
      notifyListeners();
    } else {
      searchOnList(search);
      _isSearch = true;
      notifyListeners();
    }
  }

  // getter
  TextEditingController get controller => _controller;
  FocusNode get focusNode => _focusNode;
  bool get isFocus => _isFocus;
  bool get isLoading => _isLoading;
  bool get isEmpty => _isEmpty;
  bool get isSearch => _isSearch;
  bool get isSearchResult => _isSearchResult;
  List<String> get listProductDummy => _listProductDummy;
  List<String> get listProductResult => _listProductResult;

  searchOnList(String value) {
    List<String> listToShow;
    listToShow = _listProductDummy
        .where((t) => t.toLowerCase().contains(value.toLowerCase()))
        .toList();
    _listProductResult = listToShow;
    logMe(_listProductResult);
    notifyListeners();
  }

  clearList() {
    _listProductResult.clear();
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
    notifyListeners();
  }

  final GetProductList getProductList;
  String _selectedValue = "terbaru";
  String get selectedValue => _selectedValue;
  set setSelectedVal(val) {
    _selectedValue = val;
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

  Stream<ProductState> fetchProductList() async* {
    unfocus();
    _isSearch = false;
    _isSearchResult = true;
    _isLoading = true;
    notifyListeners();

    logMe("asdaaa");
    yield ProductLoading();

    final result = await getProductList();
    yield* result.fold(
      (failure) async* {
        yield ProductFailure(failure: failure);
      },
      (data) async* {
        _isLoading = false;
        _listProduct = data.data;
        notifyListeners();
        yield ProductLoaded(data: data.data);
      },
    );
  }
}
