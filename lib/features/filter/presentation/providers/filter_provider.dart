import 'package:pas_mobile/core/presentation/form_provider.dart';
import 'package:pas_mobile/core/utility/helper.dart';
import 'package:pas_mobile/features/home/domain/usecases/get_category_list.dart';
import 'package:pas_mobile/features/category/presentation/providers/category_state.dart';

import '../../../home/data/models/category_list_response_model.dart';

class FilterProvider extends FormProvider {
  // initial
  final GetCategoryList getCategoryList;
  List<Category> _selectedFilter = [];
  final List<String> _selectedCategoryFilter = [];
  List<Category> get selectedFilter => _selectedFilter;
  List<String> get selectedCategoryFilter => _selectedCategoryFilter;
  int _priceStart = 0;
  String _mapCategory = '';
  int _priceEnd = 0;

  int get priceStart => _priceStart;
  String get mapCategory => _mapCategory;
  int get priceEnd => _priceEnd;

  setSelectedFilter(value) {
    _selectedFilter = value;
    notifyListeners();
  }

  addSelected(val) {
    _selectedFilter.add(val);
    notifyListeners();
  }

  checkCategory() {
    logMe("checkkkk");
    logMe(selectedFilter.length);
    notifyListeners();
  }

  set setListSelected(List<Category> data) {
    _selectedFilter = data;
    notifyListeners();
  }

  removeSelected(Category val) {
    _selectedFilter.removeWhere((item) => item.categoryid == val.categoryid);
    notifyListeners();
  }

  convertListCategory() {
    for (var i = 0; i < _selectedFilter.length; i++) {
      _selectedCategoryFilter.add(_selectedFilter[i].categoryid);
    }

    _mapCategory = _selectedCategoryFilter.toString();
    _mapCategory = _mapCategory.replaceAll('[', '');
    _mapCategory = _mapCategory.replaceAll(']', '');
    _mapCategory = _mapCategory.replaceAll(' ', '');
    logMe(mapCategory);
    notifyListeners();
  }

  bool isDataExist(String value) {
    var data = _selectedFilter.where((row) => (row.categoryid == value));
    if (data.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  clearFilter() {
    priceMaxController.text = '';
    priceMinController.text = '';
    _selectedFilter = [];
    notifyListeners();
  }

  checkPrice(String priceMax, String priceMin) {
    String minPriceTxt, maxPriceTxt;
    int minPrice, maxPrice;
    minPriceTxt = priceMin;
    maxPriceTxt = priceMax;
    if (priceMax.isNotEmpty && priceMin.isNotEmpty) {
      minPrice = int.parse(
          priceMinController.text.replaceAll(RegExp(r'[^\w\s]+'), ''));
      maxPrice = int.parse(
          priceMaxController.text.replaceAll(RegExp(r'[^\w\s]+'), ''));
      if (maxPrice < minPrice) {
        priceMaxController.text = minPriceTxt;
        priceMinController.text = maxPriceTxt;
      }
      _priceStart = minPrice;
      _priceEnd = maxPrice;
      notifyListeners();
    } else {
      _priceStart = priceMin.isEmpty
          ? 0
          : int.parse(
              priceMinController.text.replaceAll(RegExp(r'[^\w\s]+'), ''));
      _priceEnd = priceMax.isEmpty
          ? 0
          : int.parse(
              priceMaxController.text.replaceAll(RegExp(r'[^\w\s]+'), ''));
      notifyListeners();
    }
  }

  Stream<CategoryState> fetchCategoryList() async* {
    yield CategoryLoading();

    final result = await getCategoryList();
    yield* result.fold(
      (failure) async* {
        yield CategoryFailure(failure: failure);
      },
      (data) async* {
        List<Category> _categoryList = [];
        _categoryList = data.data;
        _categoryList.sort((a, b) {
          return a.categoryname
              .toLowerCase()
              .compareTo(b.categoryname.toLowerCase());
        });
        yield CategoryLoaded(data: _categoryList);
      },
    );
  }

  // constructor
  FilterProvider({
    required this.getCategoryList,
  });
}
