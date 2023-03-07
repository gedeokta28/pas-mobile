import 'package:equatable/equatable.dart';
import 'package:pas_mobile/features/cart/data/models/cart_response_model.dart';

import '../../../../core/error/failures.dart';

abstract class AddToCartState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddToCartInitial extends AddToCartState {}

class AddToCartLoading extends AddToCartState {}

class AddToCartSuccess extends AddToCartState {
  final CartResponseModel data;

  AddToCartSuccess({required this.data});

  @override
  List<Object?> get props => [data];
}

class AddToCartFailure extends AddToCartState {
  final Failure failure;

  AddToCartFailure({required this.failure});

  @override
  List<Object?> get props => [failure];
}
