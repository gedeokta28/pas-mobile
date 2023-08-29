import 'package:equatable/equatable.dart';
import 'package:pas_mobile/core/error/failures.dart';

abstract class DeviceTokenState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DeviceTokenInitial extends DeviceTokenState {}

class DeviceTokenLoading extends DeviceTokenState {}

class DeviceTokenSuccess extends DeviceTokenState {}

class DeviceTokenFailure extends DeviceTokenState {
  final Failure failure;

  DeviceTokenFailure({required this.failure});

  @override
  List<Object?> get props => [failure];
}
