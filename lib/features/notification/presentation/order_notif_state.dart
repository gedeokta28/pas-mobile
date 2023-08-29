import 'package:equatable/equatable.dart';
import 'package:pas_mobile/features/notification/data/models/order_notif_response_model.dart';

import '../../../../core/error/failures.dart';

abstract class OrderNotifState extends Equatable {
  final List<OrderNotif>? data;

  const OrderNotifState({this.data});
  @override
  List<Object?> get props => [];
}

class OrderNotifInitial extends OrderNotifState {}

class OrderNotifLoading extends OrderNotifState {}

class OrderNotifEmpty extends OrderNotifState {}

class OrderNotifSuccess extends OrderNotifState {
  // final DetailMotorBekasList data;
  const OrderNotifSuccess({List<OrderNotif>? data}) : super(data: data);

  @override
  List<Object?> get props => [data];
}

class OrderNotifFailure extends OrderNotifState {
  final Failure failure;

  const OrderNotifFailure({required this.failure});

  @override
  List<Object?> get props => [failure];
}
