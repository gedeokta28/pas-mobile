import 'package:equatable/equatable.dart';
import 'package:pas_mobile/features/home/data/models/product_list_response_model.dart';

import '../../../../core/error/failures.dart';

abstract class ProductState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProductEmpty extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  // final ProductList data;
  final List<Product> data;

  ProductLoaded({required this.data});

  @override
  List<Object?> get props => [data];
}

class ProductFailure extends ProductState {
  final Failure failure;

  ProductFailure({required this.failure});

  @override
  List<Object?> get props => [failure];
}
