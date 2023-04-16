import 'package:equatable/equatable.dart';
import 'package:pas_mobile/features/account/data/models/get_address_model.dart';

import '../../../../core/error/failures.dart';

abstract class ShippingAddressListState extends Equatable {
  final List<ShippingAddress>? data;

  const ShippingAddressListState({this.data});
  @override
  List<Object?> get props => [];
}

class ShippingAddressListInitial extends ShippingAddressListState {}

class ShippingAddressListLoading extends ShippingAddressListState {}

class ShippingAddressListEmpty extends ShippingAddressListState {}

class ShippingAddressListSuccess extends ShippingAddressListState {
  // final DetailMotorBekasList data;
  const ShippingAddressListSuccess({List<ShippingAddress>? data})
      : super(data: data);

  @override
  List<Object?> get props => [data];
}

class ShippingAddressListFailure extends ShippingAddressListState {
  final Failure failure;

  const ShippingAddressListFailure({required this.failure});

  @override
  List<Object?> get props => [failure];
}
