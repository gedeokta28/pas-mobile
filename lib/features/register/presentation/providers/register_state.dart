import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/register_data_model.dart';

abstract class RegisterState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final RegisterDataModel data;
  RegisterSuccess({required this.data});

  @override
  List<Object?> get props => [data];
}

class RegisterFailure extends RegisterState {
  final Failure failure;

  RegisterFailure({required this.failure});

  @override
  List<Object?> get props => [failure];
}
