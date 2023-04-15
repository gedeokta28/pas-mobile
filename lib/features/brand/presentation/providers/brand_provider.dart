import 'package:flutter/material.dart';
import 'package:pas_mobile/features/home/domain/usecases/get_brand_list.dart';

import 'brand_state.dart';

class BrandProvider extends ChangeNotifier {
  // initial
  final GetBrandList getBrandList;

  // getter

  // constructor
  BrandProvider({
    required this.getBrandList,
  });

  Stream<BrandState> fetchBrandList() async* {
    yield BrandLoading();

    final result = await getBrandList();
    yield* result.fold(
      (failure) async* {
        yield BrandFailure(failure: failure);
      },
      (data) async* {
        yield BrandLoaded(data: data);
      },
    );
  }
}
