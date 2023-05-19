import 'package:equatable/equatable.dart';

import '../../../../../core/error/failures.dart';
import '../../../home/data/models/product_list_response_model.dart';

abstract class QuickProductState extends Equatable {
  final List<Product>? data;

  const QuickProductState({this.data});
  @override
  List<Object?> get props => [];
}

class QuickProductEmpty extends QuickProductState {}

class QuickProductInitial extends QuickProductState {}

class QuickProductLoading extends QuickProductState {}

class QuickProductLoaded extends QuickProductState {
  // final QuickProductList data;
  const QuickProductLoaded({List<Product>? data}) : super(data: data);

  @override
  List<Object?> get props => [data];
}

class QuickProductFailure extends QuickProductState {
  final Failure failure;

  const QuickProductFailure({required this.failure});

  @override
  List<Object?> get props => [failure];
}
