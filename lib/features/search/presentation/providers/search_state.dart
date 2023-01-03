import 'package:equatable/equatable.dart';
import 'package:pas_mobile/features/search/data/models/filter_product_model.dart';
import 'package:pas_mobile/features/search/data/models/search_product_response_model.dart';

import '../../../../core/error/failures.dart';

abstract class SearchState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SearchEmpty extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  // final SearchList data;
  final List<ProductSearch> data;

  SearchLoaded({required this.data});

  @override
  List<Object?> get props => [data];
}

class FilterLoaded extends SearchState {
  // final SearchList data;
  final List<ProductFilter> data;

  FilterLoaded({required this.data});

  @override
  List<Object?> get props => [data];
}

class SearchFailure extends SearchState {
  final Failure failure;

  SearchFailure({required this.failure});

  @override
  List<Object?> get props => [failure];
}
