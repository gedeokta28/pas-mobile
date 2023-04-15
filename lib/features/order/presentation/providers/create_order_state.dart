import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';

abstract class CreateOrderState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CreateOrderInitial extends CreateOrderState {}

class CreateOrderLoading extends CreateOrderState {}

class CreateOrderSuccess extends CreateOrderState {
  final String orderId;

  CreateOrderSuccess({required this.orderId});

  @override
  List<Object?> get props => [orderId];
}

class CreateOrderFailure extends CreateOrderState {
  final Failure failure;

  CreateOrderFailure({required this.failure});

  @override
  List<Object?> get props => [failure];
}
