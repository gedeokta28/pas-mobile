import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/login_data_model.dart';

abstract class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final LoginDataModel data;
  LoginSuccess({required this.data});

  @override
  List<Object?> get props => [data];
}

class LoginFailure extends LoginState {
  final Failure failure;

  LoginFailure({required this.failure});

  @override
  List<Object?> get props => [failure];
}
