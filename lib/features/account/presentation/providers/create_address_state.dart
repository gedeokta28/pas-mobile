import 'package:equatable/equatable.dart';
import 'package:pas_mobile/features/account/data/models/create_address_response_model.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/update_profile_response_model.dart';

abstract class CreateAdressState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CreateAdressInitial extends CreateAdressState {}

class CreateAdressLoading extends CreateAdressState {}

class CreateAdressSuccess extends CreateAdressState {
  final CreateAddressResponseModel data;

  CreateAdressSuccess({required this.data});

  @override
  List<Object?> get props => [data];
}

class CreateAdressFailure extends CreateAdressState {
  final Failure failure;

  CreateAdressFailure({required this.failure});

  @override
  List<Object?> get props => [failure];
}
