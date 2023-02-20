import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/update_profile_response_model.dart';

abstract class UpdateProfileState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UpdateProfileInitial extends UpdateProfileState {}

class UpdateProfileLoading extends UpdateProfileState {}

class UpdateProfileSuccess extends UpdateProfileState {
  final UpdateProfileResponse data;

  UpdateProfileSuccess({required this.data});

  @override
  List<Object?> get props => [data];
}

class UpdateProfileFailure extends UpdateProfileState {
  final Failure failure;

  UpdateProfileFailure({required this.failure});

  @override
  List<Object?> get props => [failure];
}
