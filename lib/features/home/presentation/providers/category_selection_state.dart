import 'package:equatable/equatable.dart';
import 'package:pas_mobile/features/home/data/models/product_list_response_model.dart';

import '../../../../core/error/failures.dart';
import '../../../home/data/models/category_list_response_model.dart';

abstract class CategorySelectionState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CategorySelectionEmpty extends CategorySelectionState {}

class CategorySelectionLoading extends CategorySelectionState {}

class CategorySelectionLoaded extends CategorySelectionState {
  final List<Category> data;

  CategorySelectionLoaded({required this.data});

  @override
  List<Object?> get props => [data];
}

class CategorySelectionFailure extends CategorySelectionState {
  final Failure failure;

  CategorySelectionFailure({required this.failure});

  @override
  List<Object?> get props => [failure];
}
