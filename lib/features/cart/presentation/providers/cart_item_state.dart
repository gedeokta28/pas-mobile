import 'package:equatable/equatable.dart';
import 'package:pas_mobile/features/cart/data/models/cart_list_model.dart';
import 'package:pas_mobile/features/cart/data/models/cart_response_model.dart';

import '../../../../core/error/failures.dart';

abstract class CartItemState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CartItemInitial extends CartItemState {}

class CartItemLoading extends CartItemState {}

class CartItemSuccess extends CartItemState {
  final List<ItemCart> data;

  CartItemSuccess({required this.data});

  @override
  List<Object?> get props => [data];
}

class CartItemFailure extends CartItemState {
  final Failure failure;

  CartItemFailure({required this.failure});

  @override
  List<Object?> get props => [failure];
}
