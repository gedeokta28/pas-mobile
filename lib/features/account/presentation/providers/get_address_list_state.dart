import 'package:equatable/equatable.dart';
import 'package:pas_mobile/features/account/data/models/get_address_model.dart';

import '../../../../core/error/failures.dart';

abstract class GetAddressListState extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetAddressListInitial extends GetAddressListState {}

class GetAddressListLoading extends GetAddressListState {}

class GetAddressListSuccess extends GetAddressListState {
  final List<ShippingAddress> data;

  GetAddressListSuccess({required this.data});

  @override
  List<Object?> get props => [data];
}

class GetAddressListFailure extends GetAddressListState {
  final Failure failure;

  GetAddressListFailure({required this.failure});

  @override
  List<Object?> get props => [failure];
}
