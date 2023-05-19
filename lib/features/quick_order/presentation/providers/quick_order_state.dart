import 'package:equatable/equatable.dart';
import 'package:pas_mobile/features/cart/data/models/cart_response_model.dart';

import '../../../../core/error/failures.dart';

abstract class AddToCartQuickOrderState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddToCartQuickOrderInitial extends AddToCartQuickOrderState {}

class AddToCartQuickOrderLoading extends AddToCartQuickOrderState {}

class AddToCartQuickOrderSuccess extends AddToCartQuickOrderState {
  final CartResponseModel data;

  AddToCartQuickOrderSuccess({required this.data});

  @override
  List<Object?> get props => [data];
}

class AddToCartQuickOrderFailure extends AddToCartQuickOrderState {
  final Failure failure;

  AddToCartQuickOrderFailure({required this.failure});

  @override
  List<Object?> get props => [failure];
}
