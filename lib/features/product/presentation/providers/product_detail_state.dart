import 'package:equatable/equatable.dart';
import 'package:pas_mobile/features/home/data/models/detail_product_model.dart';
import 'package:pas_mobile/features/home/data/models/variant_product_response_model.dart';
import 'package:pas_mobile/features/search/data/models/filter_product_model.dart';
import 'package:pas_mobile/features/search/data/models/search_product_response_model.dart';

import '../../../../core/error/failures.dart';

abstract class ProductDetailState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProductDetailEmpty extends ProductDetailState {}

class ProductDetailLoading extends ProductDetailState {}

class ProductDetailLoaded extends ProductDetailState {
  // final ProductDetailList data;
  final ProductDetail data;

  ProductDetailLoaded({required this.data});

  @override
  List<Object?> get props => [data];
}

class ProductVariantLoaded extends ProductDetailState {
  // final ProductDetailList data;
  final VariantList data;

  ProductVariantLoaded({required this.data});

  @override
  List<Object?> get props => [data];
}

class ProductDetailFailure extends ProductDetailState {
  final Failure failure;

  ProductDetailFailure({required this.failure});

  @override
  List<Object?> get props => [failure];
}
