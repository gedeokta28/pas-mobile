import 'package:flutter/material.dart';
import 'package:pas_mobile/core/presentation/form_provider.dart';
import 'package:pas_mobile/core/utility/helper.dart';
import 'package:pas_mobile/features/home/domain/usecases/get_category_list.dart';
import 'package:pas_mobile/features/category/presentation/providers/category_state.dart';

import '../../../home/data/models/category_list_response_model.dart';

class FilterProvider extends FormProvider {
  // initial
  final GetCategoryList getCategoryList;
  List<Category> _selectedFilter = [];
  List<Category> get selectedFilter => _selectedFilter;

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
    minPrice =
        int.parse(priceMinController.text.replaceAll(RegExp(r'[^\w\s]+'), ''));
    maxPrice =
        int.parse(priceMaxController.text.replaceAll(RegExp(r'[^\w\s]+'), ''));
    if (maxPrice < minPrice) {
      priceMaxController.text = minPriceTxt;
      priceMinController.text = maxPriceTxt;
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
        yield CategoryLoaded(data: data.data);
      },
    );
  }

  // constructor
  FilterProvider({
    required this.getCategoryList,
  });
}
