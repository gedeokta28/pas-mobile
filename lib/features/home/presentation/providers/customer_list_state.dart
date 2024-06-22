import 'package:equatable/equatable.dart';
import 'package:pas_mobile/features/home/data/models/customer_list_response_mode.dart';

import '../../../../core/error/failures.dart';

abstract class CustomerListState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CustomerListEmpty extends CustomerListState {}

class CustomerListLoading extends CustomerListState {}

class CustomerListLoaded extends CustomerListState {
  final List<CustomerData> data;

  CustomerListLoaded({required this.data});

  @override
  List<Object?> get props => [data];
}

class CustomerListFailure extends CustomerListState {
  final Failure failure;

  CustomerListFailure({required this.failure});

  @override
  List<Object?> get props => [failure];
}
