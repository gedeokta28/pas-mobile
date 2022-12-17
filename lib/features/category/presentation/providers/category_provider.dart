import 'package:flutter/material.dart';
import 'package:pas_mobile/features/home/domain/usecases/get_category_list.dart';
import 'package:pas_mobile/features/category/presentation/providers/category_state.dart';

class CategoryProvider extends ChangeNotifier {
  // initial
  final GetCategoryList getCategoryList;

  // getter

  // constructor
  CategoryProvider({
    required this.getCategoryList,
  });

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
}
