import 'package:equatable/equatable.dart';
import 'package:pas_mobile/features/order/data/models/order_list_model.dart';

import '../../../../core/error/failures.dart';

abstract class ListOrderState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ListOrderInitial extends ListOrderState {}

class ListOrderLoading extends ListOrderState {}

class ListOrderSuccess extends ListOrderState {
  final List<OrderDataList> listOrder;

  ListOrderSuccess({required this.listOrder});

  @override
  List<Object?> get props => [listOrder];
}

class ListOrderFailure extends ListOrderState {
  final Failure failure;

  ListOrderFailure({required this.failure});

  @override
  List<Object?> get props => [failure];
}
