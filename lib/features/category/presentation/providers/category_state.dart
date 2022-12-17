import 'package:equatable/equatable.dart';
import 'package:pas_mobile/features/home/data/models/product_list_response_model.dart';

import '../../../../core/error/failures.dart';
import '../../../home/data/models/category_list_response_model.dart';

abstract class CategoryState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CategoryEmpty extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  // final CategoryList data;
  final List<Category> data;

  CategoryLoaded({required this.data});

  @override
  List<Object?> get props => [data];
}

class CategoryFailure extends CategoryState {
  final Failure failure;

  CategoryFailure({required this.failure});

  @override
  List<Object?> get props => [failure];
}
