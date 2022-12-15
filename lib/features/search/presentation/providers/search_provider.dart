import 'package:flutter/material.dart';
import 'package:pas_mobile/core/utility/helper.dart';

class SearchProvider with ChangeNotifier {
  SearchProvider();

  // initial
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
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
}
