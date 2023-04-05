import 'package:equatable/equatable.dart';
import 'package:pas_mobile/features/order/data/models/create_order_response_model.dart';

import '../../../../core/error/failures.dart';

abstract class DetailOrderState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DetailOrderInitial extends DetailOrderState {}

class DetailOrderLoading extends DetailOrderState {}

class DetailOrderSuccess extends DetailOrderState {
  final DetailOrder detailOrder;

  DetailOrderSuccess({required this.detailOrder});

  @override
  List<Object?> get props => [detailOrder];
}

class DetailOrderFailure extends DetailOrderState {
  final Failure failure;

  DetailOrderFailure({required this.failure});

  @override
  List<Object?> get props => [failure];
}
