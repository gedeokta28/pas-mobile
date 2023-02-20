import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/profile_model.dart';

abstract class ProfileState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final Profile data;

  ProfileLoaded({required this.data});

  @override
  List<Object?> get props => [data];
}

class ProfileFailure extends ProfileState {
  final Failure failure;

  ProfileFailure({required this.failure});

  @override
  List<Object?> get props => [failure];
}
