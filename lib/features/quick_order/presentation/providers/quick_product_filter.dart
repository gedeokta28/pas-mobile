import 'package:equatable/equatable.dart';
import 'package:pas_mobile/features/search/data/models/filter_product_model.dart';

import '../../../../../core/error/failures.dart';

abstract class QuickProductFilterState extends Equatable {
  final List<ProductFilter>? data;

  const QuickProductFilterState({this.data});
  @override
  List<Object?> get props => [];
}

class QuickProductFilterEmpty extends QuickProductFilterState {}

class QuickProductFilterInitial extends QuickProductFilterState {}

class QuickProductFilterLoading extends QuickProductFilterState {}

class QuickProductFilterLoaded extends QuickProductFilterState {
  // final QuickProductFilterList data;
  const QuickProductFilterLoaded({List<ProductFilter>? data})
      : super(data: data);

  @override
  List<Object?> get props => [data];
}

class QuickProductFilterFailure extends QuickProductFilterState {
  final Failure failure;

  const QuickProductFilterFailure({required this.failure});

  @override
  List<Object?> get props => [failure];
}
